package lazebny.io.jc.logic

import JcConferenceControllerApi
import com.juphoon.cloud.JCMediaChannel
import lazebny.io.jc.logic.JcWrapper.JCManager

class JcConferenceControllerApiImpl : JcConferenceControllerApi {
    override fun enableMicrophone(value: Boolean) {
        JCManager.getInstance().mediaChannel.enableUploadAudioStream(value)
    }

    override fun enableCamera(value: Boolean) {
        JCManager.getInstance().mediaChannel.enableUploadVideoStream(value)
        if (value) {
            JCManager.getInstance().mediaDevice.startCamera()
        } else {
            JCManager.getInstance().mediaDevice.stopCamera()
        }
    }

    override fun enableSpeaker(value: Boolean) {
        JCManager.getInstance().mediaDevice.enableSpeaker(value)
    }

    override fun switchCamera() {
        JCManager.getInstance().mediaDevice.switchCamera()
    }

    override fun leave() {
        JCManager.getInstance().mediaChannel.leave()
    }

    override fun joinConference(conferenceID: String, password: String): Boolean {
        val joinParam = JCMediaChannel.JoinParam()
        joinParam.password = password
        return JCManager.getInstance().mediaChannel.join(conferenceID, joinParam)
    }
}