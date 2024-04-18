package org.strongswan.android.utils.traffic

interface ITrafficSpeedListener {
    fun onTrafficSpeedMeasured(upStream: Double, downStream: Double, totalUpStream: Long, totalDownStream: Long)
}