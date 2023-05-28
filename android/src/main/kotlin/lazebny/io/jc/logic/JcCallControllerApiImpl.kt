package lazebny.io.jc.logic

import JcCallControllerApi
import com.juphoon.cloud.JCCall
import lazebny.io.jc.logic.JcWrapper.JCManager

class JcCallControllerApiImpl : JcCallControllerApi {

    override fun enableMicrophone(value: Boolean) {
        JCManager.getInstance().call.activeCallItem?.let {
            JCManager.getInstance().call.muteMicrophone(it, !value)
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
}