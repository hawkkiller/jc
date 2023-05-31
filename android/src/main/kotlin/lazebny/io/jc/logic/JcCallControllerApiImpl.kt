package lazebny.io.jc.logic

import JcCallControllerApi
import com.juphoon.cloud.JCCall
import lazebny.io.jc.logic.JcWrapper.JCEvent.JCEvent
import lazebny.io.jc.logic.JcWrapper.JCManager
import org.greenrobot.eventbus.EventBus

class JcCallControllerApiImpl : JcCallControllerApi {

    override fun enableMicrophone(value: Boolean) {
        JCManager.getInstance().call.activeCallItem?.let {
            JCManager.getInstance().call.muteMicrophone(it, !value)
            EventBus.getDefault().post(JCEvent(JCEvent.EventType.CALL_UI))
        }
    }

    override fun enableCamera(value: Boolean) {
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

    override fun terminate() {
        JCManager.getInstance().call.activeCallItem?.let {
            JCManager.getInstance().call.term(it, JCCall.REASON_NONE, "term")
        }
    }

    override fun call(userID: String, video: Boolean, ticket: String): Boolean {
        val param = JCCall.CallParam(
            if (video) "video" else "audio",
            ticket,
        )

        JCManager.getInstance().call.updateMediaConfig(
            JCCall.MediaConfig.generateByMode(JCCall.MediaConfig.MODE_IOT_LARGE)
        )

        val res = JCManager.getInstance().call.call(userID, video, param)
        if (res) {
            JCManager.getInstance().mediaDevice.startAudio()
        }

        return res
    }
}