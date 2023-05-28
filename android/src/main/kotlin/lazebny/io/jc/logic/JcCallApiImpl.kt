package lazebny.io.jc.logic

import JcCallApi
import com.juphoon.cloud.JCCall
import lazebny.io.jc.logic.JcWrapper.JCManager

class JcCallApiImpl : JcCallApi {
    override fun call(userID: String, video: Boolean): Boolean {
        val param = JCCall.CallParam(
            if (video) "video" else "audio",
            "ticket",
        )

        JCManager.getInstance().call.updateMediaConfig(
            JCCall.MediaConfig.generateByMode(JCCall.MediaConfig.MODE_IOT_SMALL)
        )

        return JCManager.getInstance().call.call(userID, video, param)
    }
}