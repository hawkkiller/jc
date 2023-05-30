package lazebny.io.jc.platformView

import android.content.Context
import android.view.View
import android.view.ViewGroup
import com.juphoon.cloud.JCMediaChannel
import com.juphoon.cloud.JCMediaDevice
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import lazebny.io.jc.logic.JcWrapper.JCManager

class JcConferencePlatformViewFactory :
    PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        val map = args as Map<*, *>
        return JcConferencePlatformView(map["uid"] as String)
    }
}

class JcConferencePlatformView(userId: String) : PlatformView {

    private var view: View? = null

    init {
        val participant =
            JCManager.getInstance().mediaChannel.participants.find { it.userId == userId }
        this.view = participant?.startVideo(
            JCMediaDevice.RENDER_FULL_SCREEN,
            JCMediaChannel.PICTURESIZE_MIN
        )?.videoView
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