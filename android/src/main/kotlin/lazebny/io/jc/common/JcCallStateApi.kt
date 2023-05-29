package lazebny.io.jc.common

import android.util.Log
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import lazebny.io.jc.logic.JcWrapper.JCEvent.JCEvent
import org.greenrobot.eventbus.EventBus
import org.greenrobot.eventbus.Subscribe

interface JcCallStateApi {
    fun microphone(): Boolean
    fun video(): Boolean
    fun speaker(): Boolean
    fun otherMicrophone(): Boolean
    fun otherVideo(): Boolean
    fun callStatus(): String

    companion object {
        private var selfMemberSink: EventChannel.EventSink? = null
        private var otherMemberSink: EventChannel.EventSink? = null
        private var callStatusSink: EventChannel.EventSink? = null
        private var stateApi: JcCallStateApi? = null

        private fun sendSelfMember() {
            val api = stateApi ?: return
            val map = mapOf<String?, Any>(
                "video" to api.video(),
                "microphone" to api.microphone(),
                "speaker" to api.speaker(),
            )
            selfMemberSink?.success(map)
        }

        private fun sendOtherMember() {
            val api = stateApi ?: return
            val map = mapOf<String?, Any>(
                "video" to api.otherVideo(),
                "microphone" to api.otherMicrophone(),
            )
            otherMemberSink?.success(map)
        }

        private fun sendCallStatus() {
            val api = stateApi ?: return
            callStatusSink?.success(api.callStatus())
        }

        @Subscribe
        fun onEvent(event: JCEvent) {
            print("JcCallStateApi onEvent")
            val api = stateApi ?: return
            // do not trigger updates on log events
            val triggerEvents = listOf(
                JCEvent.EventType.CALL_UI,
                JCEvent.EventType.CALL_ADD,
                JCEvent.EventType.CALL_REMOVE,
                JCEvent.EventType.CALL_UPDATE,
                JCEvent.EventType.CAMERA_UPDATE,
            )
            val contains = triggerEvents.contains(event.eventType)
            if (!contains) return

            sendSelfMember()

            sendOtherMember()

            sendCallStatus()
        }

        fun setUp(binaryMessenger: BinaryMessenger, stateApi: JcCallStateApi?) {
            val selfMember =
                EventChannel(binaryMessenger, "lazebny.io.jc/jc_call_state_channel/self")
            val otherMember =
                EventChannel(binaryMessenger, "lazebny.io.jc/jc_call_state_channel/other")
            val callStatus =
                EventChannel(binaryMessenger, "lazebny.io.jc/jc_call_state_channel/status")
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
                        sendSelfMember()
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
                        sendOtherMember()
                    }

                    override fun onCancel(arguments: Any?) {
                        otherMemberSink = null
                    }
                }
            )

            callStatus.setStreamHandler(
                object : EventChannel.StreamHandler {
                    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                        callStatusSink = events
                        sendCallStatus()
                    }

                    override fun onCancel(arguments: Any?) {
                        callStatusSink = null
                    }
                }
            )

            Log.i("JcSdk", "The channels are set up, update data")
        }

    }
}