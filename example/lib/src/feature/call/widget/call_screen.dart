import 'package:flutter/material.dart';
import 'package:jc/jc.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  late final TextEditingController _calleeIdController;
  CallController? _callController;

  @override
  void initState() {
    _calleeIdController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Call'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
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
                      onPressed: () async {
                        _callController = await JcSdk.instance.call(
                          userID: v.text,
                          video: true,
                        );
                        setState(() {});
                      },
                      icon: const Icon(Icons.call),
                      label: Text('Call ${v.text}'),
                    );
                  },
                ),
              ),
              TextButton.icon(
                onPressed: () async {
                  await _callController?.terminate();
                  setState(() {
                    _callController = null;
                  });
                },
                icon: const Icon(Icons.call_end),
                label: const Text('Leave'),
              ),
              if (_callController != null) ...[
                const Text('Realtime stats: '),
                StreamBuilder<SelfMember>(
                  stream: _callController!.selfMember,
                  builder: (context, snapshot) {
                    final data = snapshot.data;
                    return Text('$data');
                  },
                ),
              ]
            ],
          ),
        ),
      );
}
