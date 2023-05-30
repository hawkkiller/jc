package lazebny.io.jc.platformView

import android.content.Context
import android.view.View
import android.view.ViewGroup
import com.juphoon.cloud.JCMediaDevice
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import lazebny.io.jc.common.JcViewController
import lazebny.io.jc.logic.JcWrapper.JCManager
import lazebny.io.jc.utils.ViewHelper

class JcCallOtherPlatformViewFactory(private val messenger: BinaryMessenger) :
    PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        return JcCallOtherPlatformView(messenger, viewId)
    }
}

class JcCallOtherPlatformView(
    private val messenger: BinaryMessenger,
    private val viewId: Int
) : PlatformView, JcViewController {

    private var view: View?

    init {
        val canvas = JCManager.getInstance().call.activeCallItem.startOtherVideo(
            JCMediaDevice.RENDER_FULL_SCREEN
        )
        this.view = canvas.videoView
        JcViewController.setUp(messenger, viewId, this)
    }

    override fun getView() = view

    override fun dispose() {
        val parent = view?.parent as ViewGroup?
        parent?.removeView(view)
        JcViewController.setUp(messenger, viewId, null)
    }

    override fun setLayoutParams(width: Double, height: Double) {
        view?.layoutParams?.width = ViewHelper.convertDpToPixel(width.toFloat()).toInt()
        view?.layoutParams?.height = ViewHelper.convertDpToPixel(height.toFloat()).toInt()
    }

}