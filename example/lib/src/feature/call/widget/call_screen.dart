import 'package:flutter/material.dart';
import 'package:jc/jc.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  late final TextEditingController _calleeIdController;
  late final CallController _callController;

  @override
  void initState() {
    _calleeIdController = TextEditingController();
    _callController = JcCallController.create();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Call'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: StreamBuilder<CallStatus>(
            stream: _callController.status,
            builder: (context, snapshot) {
              final status = snapshot.data ?? CallStatus.off;
              return StreamBuilder<SelfMember>(
                stream: _callController.selfMember,
                builder: (context, snapshot) {
                  final selfMember = snapshot.data;
                  final mic = selfMember?.microphone ?? false;
                  final video = selfMember?.video ?? false;
                  final speaker = selfMember?.speaker ?? false;
                  return StreamBuilder<Member>(
                      stream: _callController.otherMember,
                      builder: (context, snapshot) {
                        final otherMember = snapshot.data;
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
                                labelText: 'Callee ID',
                              ),
                            ),
                            ValueListenableBuilder(
                              valueListenable: _calleeIdController,
                              builder: (context, v, __) {
                                return TextButton.icon(
                                  onPressed: () async {
                                    await _callController.call(v.text, video: true);
                                    await _callController.enableCamera(value: true);
                                    await _callController.enableMicrophone(value: true);
                                    await _callController.enableSpeaker(value: true);
                                  },
                                  icon: const Icon(Icons.call),
                                  label: Text('Call ${v.text}'),
                                );
                              },
                            ),
                            if (status != CallStatus.off) ...[
                              Wrap(
                                children: [
                                  TextButton.icon(
                                    onPressed: () => _callController.terminate(),
                                    icon: const Icon(Icons.call_end_rounded),
                                    label: const Text('Terminate'),
                                  ),
                                  TextButton.icon(
                                    onPressed: () => _callController.enableCamera(value: !video),
                                    icon: video
                                        ? const Icon(Icons.videocam_rounded)
                                        : const Icon(Icons.videocam_off_rounded),
                                    label: const Text('Camera'),
                                  ),
                                  TextButton.icon(
                                    onPressed: () => _callController.enableMicrophone(value: !mic),
                                    icon: mic
                                        ? const Icon(Icons.mic_rounded)
                                        : const Icon(Icons.mic_off_rounded),
                                    label: const Text('Mic'),
                                  ),
                                  TextButton.icon(
                                    onPressed: () => _callController.enableSpeaker(value: !speaker),
                                    icon: speaker
                                        ? const Icon(Icons.volume_up_rounded)
                                        : const Icon(Icons.volume_off_rounded),
                                    label: const Text('Speaker'),
                                  ),
                                  TextButton.icon(
                                    onPressed: () => _callController.switchCamera(),
                                    icon: const Icon(Icons.cameraswitch_rounded),
                                    label: const Text('Switch Camera'),
                                  ),
                                ],
                              ),
                            ],
                            const Text('Realtime stats: '),
                            Text('Status: $status'),
                            Text('SelfMember: $selfMember'),
                            Text('OtherMember: $otherMember'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (selfMember != null && selfMember.video)
                                  const SizedBox(
                                    height: 200,
                                    width: 100,
                                    child: JcCallSelfView(),
                                  ),
                                // if (otherMember != null && otherMember.video)
                                //   const SizedBox(
                                //     height: 200,
                                //     width: 100,
                                //     child: JCCallOtherView(),
                                //   ),
                              ],
                            ),
                            if (otherMember != null && otherMember.video)
                              const SizedBox(
                                height: 200,
                                width: 100,
                                child: JCCallOtherView(),
                              ),
                          ],
                        );
                      });
                },
              );
            },
          ),
        ),
      );
}
