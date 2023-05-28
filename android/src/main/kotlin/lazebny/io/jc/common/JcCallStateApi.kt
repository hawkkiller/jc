package lazebny.io.jc.common

import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import lazebny.io.jc.logic.JcWrapper.JCEvent.JCEvent
import org.greenrobot.eventbus.EventBus
import org.greenrobot.eventbus.Subscribe

interface JcCallStateApi {
    fun audio() : Boolean
    fun video() : Boolean
    fun speaker() : Boolean
    fun otherAudio() : Boolean
    fun otherVideo() : Boolean
    fun callStatus() : String

    companion object {
        fun setUp(binaryMessenger: BinaryMessenger, channel: JcCallStateApi?) {
            val selfMember = EventChannel(binaryMessenger, "lazebny.io.jc/jc_call_state_channel/self")
            val otherMember = EventChannel(binaryMessenger, "lazebny.io.jc/jc_call_state_channel/other")
            if (channel == null) {
                EventBus.getDefault().unregister(this)
                selfMember.setStreamHandler(null)
                otherMember.setStreamHandler(null)
                return
            }
            EventBus.getDefault().register(this)
            var selfMemberSink: EventChannel.EventSink? = null
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
            var otherMemberSink: EventChannel.EventSink? = null
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

            @Subscribe
            fun onEvent(event: JCEvent) {
                // do not trigger updates on log events
                val triggerEvents = listOf(
                    JCEvent.EventType.CALL_UI,
                    JCEvent.EventType.CALL_ADD,
                    JCEvent.EventType.CALL_REMOVE,
                    JCEvent.EventType.CALL_UPDATE,
                    JCEvent.EventType.CAMERA_UPDATE,
                )
                if (!triggerEvents.contains(event.eventType)) return

                val map = mapOf<String?, Any>(
                    "video" to channel.video(),
                    "audio" to channel.audio(),
                    "otherAudio" to channel.otherAudio(),
                    "otherVideo" to channel.otherVideo(),
                    "speaker" to channel.speaker(),
                )
                selfMemberSink?.success(map)

                if (event.eventType != JCEvent.EventType.CALL_UPDATE) return

                val otherMap = mapOf<String?, Any>(
                    "video" to channel.otherVideo(),
                    "audio" to channel.otherAudio(),
                )
                otherMemberSink?.success(otherMap)
            }
        }

    }
}