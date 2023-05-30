import 'package:flutter/material.dart';
import 'package:jc/jc.dart';

class ConferenceScreen extends StatefulWidget {
  const ConferenceScreen({super.key});

  @override
  State<ConferenceScreen> createState() => _ConferenceScreenState();
}

class _ConferenceScreenState extends State<ConferenceScreen> {
  late final TextEditingController _calleeIdController;
  late final ConferenceController _conferenceController;

  @override
  void initState() {
    _calleeIdController = TextEditingController();
    _conferenceController = JcConferenceController.create();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Conference'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: StreamBuilder<ConferenceStatus>(
            stream: _conferenceController.status,
            builder: (context, snapshot) {
              final status = snapshot.data ?? CallStatus.off;
              return StreamBuilder<ConferenceSelfMember>(
                stream: _conferenceController.selfMember,
                builder: (context, snapshot) {
                  final selfMember = snapshot.data;
                  final mic = selfMember?.microphone ?? false;
                  final video = selfMember?.video ?? false;
                  final speaker = selfMember?.speaker ?? false;
                  return StreamBuilder<List<ConferenceMember>>(
                    stream: _conferenceController.members,
                    builder: (context, snapshot) {
                      final members = snapshot.data;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: _calleeIdController,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                                ),
                              ),
                              fillColor: Theme.of(context).colorScheme.primaryContainer,
                              filled: true,
                              labelText: 'Conference ID',
                            ),
                          ),
                          ValueListenableBuilder(
                            valueListenable: _calleeIdController,
                            builder: (context, v, __) {
                              return TextButton.icon(
                                onPressed: () async {
                                  await _conferenceController.joinConference(v.text);
                                  await _conferenceController.enableCamera(value: true);
                                  await _conferenceController.enableMicrophone(value: true);
                                  await _conferenceController.enableSpeaker(value: true);
                                },
                                icon: const Icon(Icons.call),
                                label: Text('Join Conference ${v.text}'),
                              );
                            },
                          ),
                          if (status != ConferenceStatus.off) ...[
                            Wrap(
                              children: [
                                TextButton.icon(
                                  onPressed: () => _conferenceController.leave(),
                                  icon: const Icon(Icons.call_end_rounded),
                                  label: const Text('Terminate'),
                                ),
                                TextButton.icon(
                                  onPressed: () =>
                                      _conferenceController.enableCamera(value: !video),
                                  icon: video
                                      ? const Icon(Icons.videocam_rounded)
                                      : const Icon(Icons.videocam_off_rounded),
                                  label: const Text('Camera'),
                                ),
                                TextButton.icon(
                                  onPressed: () =>
                                      _conferenceController.enableMicrophone(value: !mic),
                                  icon: mic
                                      ? const Icon(Icons.mic_rounded)
                                      : const Icon(Icons.mic_off_rounded),
                                  label: const Text('Mic'),
                                ),
                                TextButton.icon(
                                  onPressed: () =>
                                      _conferenceController.enableSpeaker(value: !speaker),
                                  icon: speaker
                                      ? const Icon(Icons.volume_up_rounded)
                                      : const Icon(Icons.volume_off_rounded),
                                  label: const Text('Speaker'),
                                ),
                                TextButton.icon(
                                  onPressed: () => _conferenceController.switchCamera(),
                                  icon: const Icon(Icons.cameraswitch_rounded),
                                  label: const Text('Switch Camera'),
                                ),
                              ],
                            ),
                          ],
                          const Text('Realtime stats: '),
                          Text('Status: $status'),
                          Text('SelfMember: $selfMember'),
                          Text('Members: $members'),
                          if (selfMember != null && selfMember.video)
                            SizedBox(
                              height: 200,
                              width: 100,
                              child: JCConferenceView(
                                uid: selfMember.uid,
                              ),
                            ),
                          SizedBox(
                            height: 200,
                            child: ListView.separated(
                              separatorBuilder: (context, index) => const SizedBox(
                                width: 16,
                              ),
                              itemBuilder: (context, index) {
                                final member = members![index];
                                return SizedBox(
                                  height: 200,
                                  width: 100,
                                  child: member.video
                                      ? JCConferenceView(
                                          uid: member.uid,
                                        )
                                      : null,
                                );
                              },
                              itemCount: members?.length ?? 0,
                            ),
                          )
                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      );
}
