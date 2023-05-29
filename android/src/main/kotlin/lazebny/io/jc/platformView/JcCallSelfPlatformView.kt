package lazebny.io.jc.platformView

import android.content.Context
import android.view.View
import android.view.ViewGroup
import android.widget.FrameLayout
import com.juphoon.cloud.JCMediaDevice
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import lazebny.io.jc.logic.JcWrapper.JCManager

class JcCallSelfPlatformViewFactory :
    PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        return JcCallSelfPlatformView(context!!)
    }

}

class JcCallSelfPlatformView(context: Context) : PlatformView {

    private var view: View? = null

    init {
        view = FrameLayout(context)

        val canvas = JCManager.getInstance().call.activeCallItem.startSelfVideo(
            JCMediaDevice.RENDER_FULL_SCREEN
        )
        this.view = canvas.videoView
    }


    override fun getView(): View? {
        return this.view
    }

    override fun dispose() {
        view?.parent?.let {
            (it as ViewGroup).removeView(this.view)
        }
    }

}