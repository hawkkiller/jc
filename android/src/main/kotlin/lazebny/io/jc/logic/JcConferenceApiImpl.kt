package lazebny.io.jc.logic

import JcConferenceApi
import com.juphoon.cloud.JCCall
import com.juphoon.cloud.JCMediaChannel
import lazebny.io.jc.logic.JcWrapper.JCManager

class JcConferenceApiImpl : JcConferenceApi {
    override fun joinConference(conferenceID: String, password: String): Boolean {
        val joinParam = JCMediaChannel.JoinParam()
        joinParam.password = password
        JCManager.getInstance().call.updateMediaConfig(JCCall.MediaConfig.generateByMode(JCCall.MediaConfig.MODE_720P))

        return JCManager.getInstance().mediaChannel.join(conferenceID, joinParam)
    }
}