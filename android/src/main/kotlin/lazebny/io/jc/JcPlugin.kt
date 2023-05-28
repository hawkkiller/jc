package lazebny.io.jc

import JcApi
import io.flutter.embedding.engine.plugins.FlutterPlugin
import lazebny.io.jc.logic.JcApiImpl

/** JcPlugin */
class JcPlugin : FlutterPlugin {

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val jcApi = JcApiImpl()
        JcApi.setUp(flutterPluginBinding.binaryMessenger, jcApi)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        JcApi.setUp(binding.binaryMessenger, null)
    }
}
