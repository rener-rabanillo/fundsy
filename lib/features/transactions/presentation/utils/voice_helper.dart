import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

/// Helper class to handle speech-to-text recognition for voice transaction entries.
class VoiceHelper {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isInitialized = false;

  /// Initializes the speech recognition service.
  Future<bool> initialize() async {
    if (_isInitialized) return true;

    try {
      _isInitialized = await _speech.initialize(
        onStatus: (status) => debugPrint('Speech status: $status'),
        onError: (error) => debugPrint('Speech error: $error'),
      );
    } catch (e) {
      debugPrint('Initialization exception: $e');
      _isInitialized = false;
    }

    return _isInitialized;
  }

  /// Starts listening to user speech and returns recognized words via callback.
  void startListening({required Function(String text) onResult}) async {
    bool available = await initialize();

    if (available) {
      debugPrint('Speech recognition available, listening started...');
      _speech.listen(
        onResult: (result) {
          debugPrint('Recognized: ${result.recognizedWords}');
          onResult(result.recognizedWords);
        },
      );
    } else {
      debugPrint('Speech recognition is not available on this device.');
    }
  }

  /// Stops the active speech listening session.
  void stopListening() async {
    await _speech.stop();
  }

  /// Disposes speech resources when no longer needed.
  void dispose() {
    _speech.stop();
  }
}