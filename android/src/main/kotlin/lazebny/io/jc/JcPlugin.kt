package lazebny.io.jc

import JcApi
import io.flutter.embedding.engine.plugins.FlutterPlugin
import lazebny.io.jc.common.JcCallStateApi
import lazebny.io.jc.common.JcConferenceStateApi
import lazebny.io.jc.logic.JcApiImpl
import lazebny.io.jc.logic.JcCallControllerApiImpl
import lazebny.io.jc.logic.JcCallStateApiImpl
import lazebny.io.jc.logic.JcConferenceControllerApiImpl
import lazebny.io.jc.logic.JcConferenceStateApiImpl
import lazebny.io.jc.platformView.JcCallOtherPlatformViewFactory
import lazebny.io.jc.platformView.JcConferencePlatformViewFactory
import lazebny.io.jc.platformView.JcCallSelfPlatformViewFactory

/** JcPlugin */
class JcPlugin : FlutterPlugin {

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val jcApi = JcApiImpl(flutterPluginBinding.applicationContext)
        val jcCallControllerApi = JcCallControllerApiImpl()
        val jcCallStateApi = JcCallStateApiImpl()
        val jcConferenceControllerApi = JcConferenceControllerApiImpl()
        val jcConferenceStateApi = JcConferenceStateApiImpl()
        JcApi.setUp(flutterPluginBinding.binaryMessenger, jcApi)
        JcCallControllerApi.setUp(flutterPluginBinding.binaryMessenger, jcCallControllerApi)
        JcCallStateApi.setUp(flutterPluginBinding.binaryMessenger, jcCallStateApi)
        JcConferenceControllerApi.setUp(
            flutterPluginBinding.binaryMessenger,
            jcConferenceControllerApi,
        )
        JcConferenceStateApi.setUp(
            flutterPluginBinding.binaryMessenger,
            jcConferenceStateApi,
        )
        flutterPluginBinding.platformViewRegistry.registerViewFactory(
            "JcCallSelfView",
            JcCallSelfPlatformViewFactory(flutterPluginBinding.binaryMessenger),
        )
        flutterPluginBinding.platformViewRegistry.registerViewFactory(
            "JcCallOtherView",
            JcCallOtherPlatformViewFactory(flutterPluginBinding.binaryMessenger),
        )
        flutterPluginBinding.platformViewRegistry.registerViewFactory(
            "JcConferenceView",
            JcConferencePlatformViewFactory(flutterPluginBinding.binaryMessenger),
        )
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        JcApi.setUp(binding.binaryMessenger, null)
        JcCallControllerApi.setUp(binding.binaryMessenger, null)
        JcCallStateApi.setUp(binding.binaryMessenger, null)
    }
}
