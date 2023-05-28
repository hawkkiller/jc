package lazebny.io.jc.logic

import com.juphoon.cloud.JCCall
import lazebny.io.jc.common.JcCallStateApi
import lazebny.io.jc.logic.JcWrapper.JCManager

class JcCallStateApiImpl : JcCallStateApi {
    override fun audio(): Boolean {
        return !JCManager.getInstance().call.activeCallItem.microphoneMute
    }

    override fun video(): Boolean {
        val uploadAudio = JCManager.getInstance().call.activeCallItem?.uploadVideoStreamSelf ?: false
        val isCameraOpen = JCManager.getInstance().mediaDevice.isCameraOpen
        return uploadAudio && isCameraOpen
    }

    override fun speaker(): Boolean {
        return JCManager.getInstance().mediaDevice.isSpeakerOn
    }

    override fun otherAudio(): Boolean {
        return !(JCManager.getInstance().call.activeCallItem?.otherAudioInterrupt ?: true)
    }

    override fun otherVideo(): Boolean {
        return JCManager.getInstance().call.activeCallItem?.uploadVideoStreamOther ?: false
    }

    override fun callStatus(): String {
        val call = JCManager.getInstance().call
        val activeCall = call.activeCallItem ?: return "off"
        return when (activeCall.state) {
            JCCall.STATE_OK, JCCall.STATE_TALKING -> "on"
            JCCall.STATE_PENDING, JCCall.STATE_CONNECTING, JCCall.STATE_INIT -> "waiting"
            else -> "off"
        }
    }
}