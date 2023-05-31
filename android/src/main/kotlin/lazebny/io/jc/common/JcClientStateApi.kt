package lazebny.io.jc.common

import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import lazebny.io.jc.logic.JcWrapper.JCEvent.JCEvent
import org.greenrobot.eventbus.EventBus
import org.greenrobot.eventbus.Subscribe

interface JcClientStateApi {
    fun getClientState() : Int

    companion object {
        private var stateApi: JcClientStateApi? = null
        private var stateChannelSink: EventChannel.EventSink? = null

        @Subscribe
        fun onEvent(event: JCEvent) {
            if (event.eventType != JCEvent.EventType.CLIENT_STATE_CHANGE) {
                return
            }
            sendClientState()
        }

        private fun sendClientState() {
            val api = stateApi ?: return
            stateChannelSink?.success(api.getClientState())
        }

        fun setUp(binaryMessenger: BinaryMessenger, stateApi: JcClientStateApi?) {
            this.stateApi = stateApi
            val stateChannel = EventChannel(binaryMessenger,"lazebny.io.jc/client_state_event_channel")
            if (stateApi == null) {
                stateChannel.setStreamHandler(null)
                EventBus.getDefault().unregister(this)
                return
            }
            stateChannel.setStreamHandler(object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    stateChannelSink = events
                    sendClientState()
                }

                override fun onCancel(arguments: Any?) {
                    stateChannelSink = null
                }
            })
            EventBus.getDefault().register(this)
        }
    }
}