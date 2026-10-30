import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

/// Helper class to handle receipt scanning via camera OCR using ML Kit.
class OcrHelper {
  final TextRecognizer _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  final ImagePicker _imagePicker = ImagePicker();

  /// Captures an image from the camera and extracts text from the receipt.
  Future<String?> extractTextFromCamera() async {
    try {
      final XFile? image = await _imagePicker.pickImage(source: ImageSource.camera);
      if (image == null) return null;

      final InputImage inputImage = InputImage.fromFilePath(image.path);
      final RecognizedText recognizedText = await _textRecognizer.processImage(inputImage);

      return recognizedText.text; // Returns all extracted receipt text
    } catch (e) {
      debugPrint('OCR Error: $e');
      return null;
    }
  }

  /// Disposes text recognizer resources.
  void dispose() {
    _textRecognizer.close();
  }
}