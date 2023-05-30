package lazebny.io.jc.utils

import android.content.res.Resources
import android.util.TypedValue

class ViewHelper {
    companion object {
        fun convertDpToPixel(dp: Float) : Float {
            return TypedValue.applyDimension(
                TypedValue.COMPLEX_UNIT_DIP,
                dp,
                Resources.getSystem().displayMetrics)
        }
    }
}