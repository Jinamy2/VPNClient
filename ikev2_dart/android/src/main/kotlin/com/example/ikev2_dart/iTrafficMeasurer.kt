package com.example.ikev2_dart

import io.flutter.plugin.common.EventChannel
import org.strongswan.android.utils.traffic.ITrafficSpeedListener

object iTrafficMeasurer : EventChannel.StreamHandler, ITrafficSpeedListener {

    private var eventSink: EventChannel.EventSink? = null
    override fun onTrafficSpeedMeasured(
        upStream: Double, downStream: Double, totalUpStream: Long, totalDownStream: Long
    ) {

        eventSink?.success(
            mapOf(
                "uploadSpeed" to upStream,
                "downloadSpeed" to downStream,
                "totalUpload" to totalUpStream,
                "totalDownload" to totalDownStream
            )
        )

    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }

}