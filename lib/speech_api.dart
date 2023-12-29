// this class is responsible for interacting with the Speech-to-Text API
import 'package:flutter/cupertino.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechApi {
  // create an object of SpeechToText
  static final speech = SpeechToText();
  // function to toggle between listening and not listening using a floating button
  static Future<bool> startListening(
      {
      // callback function to handle the recognized text
      required Function(String text) onResult,
      // callback function to handle changes in listening status.
      required ValueChanged<bool> onListening}) async {
    // if already listening, stop and return true.
    if (speech.isListening) {
      speech.stop();
      return true;
    }
    // initialize the SpeechToText plugin
    final isAvaliable = await speech.initialize(
      // callback for changes in listening status
      onStatus: (status) => onListening(
        speech.isListening,
      ),
      // callback for errors during initialization
      onError: (errorNotification) => print(
        'Error: $errorNotification',
      ),
    );
    // if initialization is successful, start listening
    if (isAvaliable) {
      // callback for handling recognized speech
      speech.listen(
        onResult: (result) => onResult(result.recognizedWords),
      );
    }
    //if the user denied permission return false
    return isAvaliable;
  }
}
