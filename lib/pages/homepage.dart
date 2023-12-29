import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:clipboard/clipboard.dart';
import '../speech_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String text = "Tap the button to start speaking!";
  bool isListening = false;

  Future Record() => SpeechApi.startListening(
        onResult: (text) => setState(() => this.text = text),
        onListening: (value) => setState(() {
          isListening = value;
        }),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black45,
        title: const Text(
          "Speech to Text",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                onPressed: () async {
                  await FlutterClipboard.copy(text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Copied to Clipboard"),
                    ),
                  );
                },
                icon: const Icon(Icons.copy, color: Colors.black),
              );
            }
          ),
        ],
      ),
      body: SingleChildScrollView(
        reverse: true,
        padding: const EdgeInsets.all(30),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 30.0,
            color: Colors.black54,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        glowColor: Theme.of(context).colorScheme.primary,
        glowRadiusFactor: 0.5,
        animate: isListening,
        child: FloatingActionButton(
            backgroundColor: Colors.grey.shade600,
            onPressed: Record,
            child: Icon(
              isListening ? Icons.mic : Icons.mic_off,
              size: 36,
            )),
      ),
    );
  }
}
