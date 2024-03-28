package org.strongswan.android.utils.traffic

import android.net.TrafficStats
import android.os.*


class TrafficSpeedMeasurer(private val trafficType: TrafficType) {
    companion object {
        private const val SAMPLE_TIME = 1000L
        private const val MSG_START = 1
    }

    private var mTrafficSpeedListener: ITrafficSpeedListener? = null
    private var mHandler: SamplingHandler

    private var mLastTimeReading = 0L
    private var mPreviousUpStream = 0L
    private var mPreviousDownStream = 0L
    private var mStartTX = 0L//UpStream
    private var mStartRX = 0L//DownStream

    init {
        val thread = HandlerThread("ParseThread")
        thread.start()
        mHandler = SamplingHandler(thread.looper)
    }

    fun registerListener(iTrafficSpeedListener: ITrafficSpeedListener) {
        mTrafficSpeedListener = iTrafficSpeedListener
    }

    fun removeListener(iTrafficSpeedListener: ITrafficSpeedListener) {
        mTrafficSpeedListener = iTrafficSpeedListener
    }

    fun startMeasuring() {
        mStartRX = TrafficStats.getTotalRxBytes()
        mStartTX = TrafficStats.getTotalTxBytes()
        mHandler.startSamplingThread()
    }

    fun stopMeasuring() {
        mHandler.stopSamplingThread();
        finalReadTrafficStats();
    }

    private fun readTrafficStats() {
        val newBytesUpStream = if (trafficType == TrafficType.MOBILE) {
            TrafficStats.getMobileTxBytes()
        } else {
            TrafficStats.getTotalTxBytes() * 1024
        }

        val newBytesDownStream = if (trafficType == TrafficType.MOBILE) {
            TrafficStats.getMobileRxBytes()
        } else {
            TrafficStats.getTotalRxBytes() * 1024
        }

        val byteDiffUpStream = newBytesUpStream - mPreviousUpStream
        val byteDiffDownStream = newBytesDownStream - mPreviousDownStream

        synchronized(this) {
            val currentTime = SystemClock.elapsedRealtime()
            var bandwidthUpStream = 0.0
            var bandwidthDownStream = 0.0

            if (mPreviousUpStream >= 0) {
                bandwidthUpStream = (byteDiffUpStream) * 1.0 / (currentTime - mLastTimeReading)
            }

            if (mPreviousDownStream >= 0) {
                bandwidthDownStream = (byteDiffDownStream) * 1.0 / (currentTime - mLastTimeReading)
            }

            val txBytes = TrafficStats.getTotalTxBytes() - mStartTX
            val rxBytes = TrafficStats.getTotalRxBytes() - mStartRX

            mTrafficSpeedListener?.onTrafficSpeedMeasured(bandwidthUpStream, bandwidthDownStream, txBytes, rxBytes)

            mLastTimeReading = currentTime
        }

        mPreviousDownStream = newBytesDownStream
        mPreviousUpStream = newBytesUpStream
    }

    private fun finalReadTrafficStats() {
        readTrafficStats()
        mPreviousUpStream = -1
        mPreviousDownStream = -1
    }

    inner class SamplingHandler(looper: Looper) : Handler(looper) {
        override fun handleMessage(msg: Message) {
            when (msg.what) {
                MSG_START -> {
                    readTrafficStats()
                    sendEmptyMessageDelayed(MSG_START, SAMPLE_TIME)
                }
                else -> throw  IllegalArgumentException("Unknown what=" + msg.what);
            }
        }

        fun startSamplingThread() {
            sendEmptyMessage(MSG_START)
        }

        fun stopSamplingThread() {
            removeMessages(MSG_START)
        }
    }
}