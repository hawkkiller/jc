package lazebny.io.jc.common

import android.util.Log
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import lazebny.io.jc.logic.JcWrapper.JCEvent.JCEvent
import org.greenrobot.eventbus.EventBus
import org.greenrobot.eventbus.Subscribe

interface JcConferenceStateApi {
    fun microphone(): Boolean

    fun video(): Boolean

    fun speaker(): Boolean

    fun conferenceStatus(): String

    fun uid(): String

    fun members(): List<Map<String, *>>

    companion object {
        private var selfMemberSink: EventChannel.EventSink? = null
        private var membersSink: EventChannel.EventSink? = null
        private var conferenceStatusSink: EventChannel.EventSink? = null
        private var stateApi: JcConferenceStateApi? = null

        private fun sendSelfMember() {
            val api = stateApi ?: return
            val map = mapOf<String?, Any>(
                "video" to api.video(),
                "microphone" to api.microphone(),
                "speaker" to api.speaker(),
                "uid" to api.uid(),
            )
            selfMemberSink?.success(map)
        }

        private fun sendMembers() {
            val api = stateApi ?: return
            val members = api.members()
            membersSink?.success(members)
        }

        private fun sendConferenceStatus() {
            val api = stateApi ?: return
            conferenceStatusSink?.success(api.conferenceStatus())
        }

        @Subscribe
        fun onEvent(event: JCEvent) {
            // do not trigger updates on log events
//            val triggerEvents = listOf(
//                JCEvent.EventType.CONFERENCE_JOIN,
//                JCEvent.EventType.CONFERENCE_LEAVE,
//                JCEvent.EventType.CONFERENCE_QUERY,
//                JCEvent.EventType.CONFERENCE_STOP,
//                JCEvent.EventType.CONFERENCE_PARTP_JOIN,
//                JCEvent.EventType.CONFERENCE_PARTP_LEAVE,
//                JCEvent.EventType.CONFERENCE_PARTP_UPDATE,
//                JCEvent.EventType.CONFERENCE_PROP_CHANGE,
//                JCEvent.EventType.CONFERENCE_MESSAGE_RECEIVED,
//                JCEvent.EventType.CAMERA_UPDATE,
//            )
//            val contains = triggerEvents.contains(event.eventType)
//            if (!contains) return

            sendSelfMember()

            sendMembers()

            sendConferenceStatus()
        }

        fun setUp(binaryMessenger: BinaryMessenger, stateApi: JcConferenceStateApi?) {
            val selfMember =
                EventChannel(binaryMessenger, "lazebny.io.jc/jc_conference_state_channel/self")
            val members =
                EventChannel(binaryMessenger, "lazebny.io.jc/jc_conference_state_channel/members")
            val conferenceStatus =
                EventChannel(binaryMessenger, "lazebny.io.jc/jc_conference_state_channel/status")
            this.stateApi = stateApi
            if (stateApi == null) {
                EventBus.getDefault().unregister(this)
                selfMember.setStreamHandler(null)
                members.setStreamHandler(null)
                conferenceStatus.setStreamHandler(null)
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
            members.setStreamHandler(
                object : EventChannel.StreamHandler {
                    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                        membersSink = events
                        sendMembers()
                    }

                    override fun onCancel(arguments: Any?) {
                        membersSink = null
                    }
                }
            )
            conferenceStatus.setStreamHandler(
                object : EventChannel.StreamHandler {
                    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                        conferenceStatusSink = events
                        sendConferenceStatus()
                    }

                    override fun onCancel(arguments: Any?) {
                        conferenceStatusSink = null
                    }
                }
            )

            Log.i("JcSdk", "The channels are set up, update data")
        }
    }
}