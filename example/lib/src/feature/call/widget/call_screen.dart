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
                  Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: ValueListenableBuilder(
                      valueListenable: _calleeIdController,
                      builder: (context, v, __) {
                        return TextButton.icon(
                          onPressed: () => _callController.call(v.text, video: true),
                          icon: const Icon(Icons.call),
                          label: Text('Call ${v.text}'),
                        );
                      },
                    ),
                  ),
                  if (status != CallStatus.off)
                    TextButton.icon(
                      onPressed: () => _callController.terminate(),
                      icon: const Icon(Icons.call_end),
                      label: const Text('Leave'),
                    ),
                  const Text('Realtime stats: '),
                  Text('Status: $status'),
                  StreamBuilder<SelfMember>(
                    stream: _callController.selfMember,
                    builder: (context, snapshot) {
                      final data = snapshot.data;
                      return Text('SelfMember: $data');
                    },
                  ),
                  StreamBuilder<Member>(
                    stream: _callController.otherMember,
                    builder: (context, snapshot) {
                      final data = snapshot.data;
                      return Text('OtherMember: $data');
                    },
                  ),
                ],
              );
            },
          ),
        ),
      );
}
