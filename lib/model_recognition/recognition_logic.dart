import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter_vision/flutter_vision.dart';

class RecognitionLogic {
  static final FlutterVision vision = FlutterVision();
  static bool isProcessing = false;
  static List<Recognition> recognitions = [];

  static Future<void> loadModel() async {
    try {
      await vision.loadYoloModel(
        labels: 'assets/car_labels.txt',
        modelPath: 'assets/car.tflite',
        modelVersion: 'yolov8',
        quantization: true,
        // Enable quantization
        numThreads: 4,
        // Increase the number of threads for processing
        useGpu: true, // Enable GPU if available
      );
      print('YOLO model loaded successfully');
    } catch (e) {
      print('Error loading YOLO model: $e');
    }
  }

  static void processCameraImage(CameraImage image, CameraController controller,
      Function() updateUI) async {
    if (isProcessing) return;
    isProcessing = true;

    try {
      final bytesList = image.planes.map((plane) => plane.bytes).toList();
      if (bytesList.isEmpty) {
        print('Error: bytesList is empty');
        return;
      }

      final results = await vision.yoloOnFrame(
        bytesList: bytesList,
        imageHeight: image.height,
        imageWidth: image.width,
        iouThreshold: 0.4,
        confThreshold: 0.4,
        classThreshold: 0.5,
      );

      if (results.isNotEmpty) {
        recognitions = results.map((result) {
          final label = result['tag'] ?? '';
          final confidence = result['box'][4] ?? 0.0;

          final previewSize = controller.value.previewSize;
          final widthScale = previewSize!.width / image.width;
          final heightScale = previewSize.height / image.height;

          final x1 = result['box'][0] * widthScale;
          final y1 = result['box'][1] * heightScale;
          final x2 = result['box'][2] * widthScale;
          final y2 = result['box'][3] * heightScale;

          final rect = Rect.fromLTRB(x1, y1, x2, y2);

          return Recognition(
            label: label,
            confidence: confidence,
            rect: rect,
          );
        }).toList();
      } else {
        recognitions = [];
      }
      updateUI();
    } catch (e) {
      print('Error processing camera image: $e');
    } finally {
      isProcessing = false;
    }
  }
}

class Recognition {
  final String label;
  final double confidence;
  final Rect rect;

  Recognition({
    required this.label,
    required this.confidence,
    required this.rect,
  });
}
