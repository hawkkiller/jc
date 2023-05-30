package lazebny.io.jc.platformView

import android.content.Context
import android.view.ViewGroup
import android.widget.FrameLayout
import com.juphoon.cloud.JCMediaChannel
import com.juphoon.cloud.JCMediaDevice
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import lazebny.io.jc.common.JcViewController
import lazebny.io.jc.logic.JcWrapper.JCManager
import lazebny.io.jc.utils.ViewHelper

class JcConferencePlatformViewFactory(private val messenger: BinaryMessenger) :
    PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        val map = args as Map<*, *>
        return JcConferencePlatformView(context!!, messenger, viewId, map["uid"] as String)
    }
}

class JcConferencePlatformView(
    context: Context,
    private val messenger: BinaryMessenger,
    private val viewId: Int,
    uid: String,
) : PlatformView, JcViewController {

    private var view: FrameLayout

    init {

        val participant =
            JCManager.getInstance().mediaChannel.participants.find { it.userId == uid }
        val canvas = participant?.startVideo(
            JCMediaDevice.RENDER_FULL_SCREEN,
            JCMediaChannel.PICTURESIZE_MIN
        )
        view = FrameLayout(canvas!!.videoView.context)
        canvas.videoView.let {
            val parent = it.parent as ViewGroup?
            parent?.removeView(it)
        }
        view.addView(
            canvas.videoView,
            FrameLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.WRAP_CONTENT
            ),
        )
        JcViewController.setUp(messenger, viewId, this)
    }

    override fun getView() = view

    override fun dispose() {
        view.removeAllViews()
        JcViewController.setUp(messenger, viewId, null)
    }

    override fun setLayoutParams(width: Double, height: Double) {
        view.layoutParams?.width = ViewHelper.convertDpToPixel(width.toFloat()).toInt()
        view.layoutParams?.height = ViewHelper.convertDpToPixel(height.toFloat()).toInt()
    }

}