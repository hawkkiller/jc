package lazebny.io.jc.logic

import JcApi
import android.content.Context
import com.juphoon.cloud.JCClient
import lazebny.io.jc.logic.JcWrapper.JCManager

class JcApiImpl(private val context: Context) : JcApi {
    override fun login(appAccountNumber: String, name: String): Boolean {
        val loginParam = JCClient.LoginParam()
        JCManager.getInstance().client.displayName = name
        return JCManager.getInstance().client.login(appAccountNumber, "123", loginParam)
    }

    override fun initialize(): Boolean {
        return JCManager.getInstance().initialize(context)
    }
}