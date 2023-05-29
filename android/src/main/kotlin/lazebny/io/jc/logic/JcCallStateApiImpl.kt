package lazebny.io.jc.logic

import com.juphoon.cloud.JCCall
import lazebny.io.jc.common.JcCallStateApi
import lazebny.io.jc.logic.JcWrapper.JCManager

class JcCallStateApiImpl : JcCallStateApi {

    private val stateOK: Boolean
        get() = JCManager.getInstance().call.activeCallItem?.state == JCCall.STATE_OK
                || JCManager.getInstance().call.activeCallItem?.state == JCCall.STATE_TALKING

    override fun microphone(): Boolean {
        val microphoneMute = JCManager.getInstance().call.activeCallItem?.microphoneMute ?: true
        val audioStarted = JCManager.getInstance().mediaDevice.isAudioStart
        return audioStarted && !microphoneMute
    }

    override fun video(): Boolean {
        val uploadAudio =
            JCManager.getInstance().call.activeCallItem?.uploadVideoStreamSelf ?: false
        val isCameraOpen = JCManager.getInstance().mediaDevice.isCameraOpen
        return uploadAudio && isCameraOpen
    }

    override fun speaker(): Boolean {
        return JCManager.getInstance().mediaDevice.isSpeakerOn
    }

    override fun otherMicrophone(): Boolean {
        val audioInterrupt =
            JCManager.getInstance().call.activeCallItem?.otherAudioInterrupt ?: true

        return stateOK && !audioInterrupt
    }

    override fun otherVideo(): Boolean {
        val video = JCManager.getInstance().call.activeCallItem?.uploadVideoStreamOther ?: false

        return stateOK && video
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