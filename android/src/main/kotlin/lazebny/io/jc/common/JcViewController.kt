package lazebny.io.jc.common

import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel

interface JcViewController {
    fun setLayoutParams(width: Double, height: Double)

    companion object {
        fun setUp(
            binaryMessenger: BinaryMessenger,
            viedId: Int,
            viewController: JcViewController?
        ) {
            val methodChannel = MethodChannel(
                binaryMessenger,
                "lazebny.io.jc/JcViewController/$viedId",
            )

            if (viewController == null) {
                methodChannel.setMethodCallHandler(null)
                return
            }

            methodChannel.setMethodCallHandler { call, result ->
                when (call.method) {
                    "setLayoutParams" -> {
                        val width = call.argument<Double>("width")
                        val height = call.argument<Double>("height")
                        viewController.setLayoutParams(width!!, height!!)
                        result.success(null)
                    }

                    else -> {
                        result.notImplemented()
                    }
                }
            }
        }
    }
}
