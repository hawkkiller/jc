package lazebny.io.jc

import JcApi
import JcConferenceApi
import io.flutter.embedding.engine.plugins.FlutterPlugin
import lazebny.io.jc.logic.JcApiImpl
import lazebny.io.jc.logic.JcCallApiImpl
import lazebny.io.jc.logic.JcCallControllerApiImpl
import lazebny.io.jc.logic.JcConferenceApiImpl

/** JcPlugin */
class JcPlugin : FlutterPlugin {

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val jcApi = JcApiImpl()
        val jcCallApi = JcCallApiImpl()
        val jcConferenceApi = JcConferenceApiImpl()
        val jcCallControllerApi = JcCallControllerApiImpl()
        JcApi.setUp(flutterPluginBinding.binaryMessenger, jcApi)
        JcCallApi.setUp(flutterPluginBinding.binaryMessenger, jcCallApi)
        JcConferenceApi.setUp(flutterPluginBinding.binaryMessenger, jcConferenceApi)
        JcCallControllerApi.setUp(flutterPluginBinding.binaryMessenger, jcCallControllerApi)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        JcApi.setUp(binding.binaryMessenger, null)
        JcCallApi.setUp(binding.binaryMessenger, null)
        JcConferenceApi.setUp(binding.binaryMessenger, null)
        JcCallControllerApi.setUp(binding.binaryMessenger, null)
    }
}
