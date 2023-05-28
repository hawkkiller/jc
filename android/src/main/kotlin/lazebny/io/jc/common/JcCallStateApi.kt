package lazebny.io.jc.common

import android.util.Log
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import lazebny.io.jc.logic.JcWrapper.JCEvent.JCEvent
import org.greenrobot.eventbus.EventBus
import org.greenrobot.eventbus.Subscribe

interface JcCallStateApi {
    fun microphone() : Boolean
    fun video() : Boolean
    fun speaker() : Boolean
    fun otherMicrophone() : Boolean
    fun otherVideo() : Boolean
    fun callStatus() : String

    companion object {
        private var selfMemberSink: EventChannel.EventSink? = null
        private var otherMemberSink: EventChannel.EventSink? = null
        private var stateApi: JcCallStateApi? = null

        @Subscribe
        fun onEvent(event: JCEvent) {
            val api = stateApi ?: return
            // do not trigger updates on log events
//            val triggerEvents = listOf(
//                JCEvent.EventType.CALL_UI,
//                JCEvent.EventType.CALL_ADD,
//                JCEvent.EventType.CALL_REMOVE,
//                JCEvent.EventType.CALL_UPDATE,
//                JCEvent.EventType.CAMERA_UPDATE,
//            )
//            if (!triggerEvents.contains(event.eventType)) return

            val map = mapOf<String?, Any>(
                "video" to api.video(),
                "microphone" to api.microphone(),
                "speaker" to api.speaker(),
            )
            selfMemberSink?.success(map)
            Log.i("JcSdk", "${event.eventType.name} $map")

            if (event.eventType != JCEvent.EventType.CALL_UPDATE) return

            val otherMap = mapOf<String?, Any>(
                "video" to api.otherVideo(),
                "microphone" to api.otherMicrophone(),
            )
            otherMemberSink?.success(otherMap)
        }

        fun setUp(binaryMessenger: BinaryMessenger, stateApi: JcCallStateApi?) {
            val selfMember = EventChannel(binaryMessenger, "lazebny.io.jc/jc_call_state_channel/self")
            val otherMember = EventChannel(binaryMessenger, "lazebny.io.jc/jc_call_state_channel/other")
            this.stateApi = stateApi
            if (stateApi == null) {
                EventBus.getDefault().unregister(this)
                selfMember.setStreamHandler(null)
                otherMember.setStreamHandler(null)
                return
            }

            EventBus.getDefault().register(this)
            selfMember.setStreamHandler(
                object : EventChannel.StreamHandler {
                    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                        selfMemberSink = events
                    }

                    override fun onCancel(arguments: Any?) {
                        selfMemberSink = null
                    }
                }
            )
            otherMember.setStreamHandler(
                object : EventChannel.StreamHandler {
                    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                        otherMemberSink = events
                    }

                    override fun onCancel(arguments: Any?) {
                        otherMemberSink = null
                    }
                }
            )
            println("The channels are set up")
            Log.i("JcSdk","The channels are set up")
        }

    }
}