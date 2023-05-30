package lazebny.io.jc.logic

import lazebny.io.jc.common.JcConferenceStateApi
import lazebny.io.jc.logic.JcWrapper.JCManager

class JcConferenceStateApiImpl : JcConferenceStateApi {
    override fun microphone(): Boolean {
        val uploadLocalAudio = JCManager.getInstance().mediaChannel.uploadLocalAudio
        val isAudioStart = JCManager.getInstance().mediaDevice.isAudioStart
        return uploadLocalAudio && isAudioStart
    }

    override fun video(): Boolean {
        val uploadLocalAudio = JCManager.getInstance().mediaChannel.uploadLocalVideo
        val isCameraOpen = JCManager.getInstance().mediaDevice.isCameraOpen
        return uploadLocalAudio && isCameraOpen
    }

    override fun speaker(): Boolean {
        return JCManager.getInstance().mediaDevice.isSpeakerOn
    }

    override fun uid(): String {
        return JCManager.getInstance().mediaChannel?.selfParticipant?.userId ?: ""
    }

    override fun conferenceStatus(): String {
        val participants = JCManager.getInstance()?.mediaChannel?.participants
        if (participants.isNullOrEmpty()) {
            return "off"
        }

        if (participants.size == 1) {
            return "waiting"
        }

        return "on"
    }

    override fun members(): List<Map<String, *>> {
        val participants = JCManager.getInstance()?.mediaChannel?.participants
        if (participants.isNullOrEmpty()) {
            return emptyList()
        }

        val participantsWithoutSelf = participants.toMutableList()
        participantsWithoutSelf.remove(JCManager.getInstance().mediaChannel.selfParticipant)

        return participantsWithoutSelf.map {
            mapOf(
                "uid" to it.userId,
                "name" to it.displayName,
                "microphone" to it.isAudio,
                "video" to it.isVideo,
            )
        }
    }
}