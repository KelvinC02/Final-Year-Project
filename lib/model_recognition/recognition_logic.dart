import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:alarmplayer/alarmplayer.dart';

class RecognitionLogic {
  static final FlutterVision vision = FlutterVision();
  static bool isProcessing = false;
  static List<Recognition> recognitions = [];
  static bool isPedestrianAlertShown = false;
  static bool isTrafficLightGreenAlertShown = false;
  static bool isTrafficLightRedAlertShown = false;
  static Alarmplayer alarmPlayer = Alarmplayer();
  static bool isAlarmPlaying = false;

  static Future<void> loadModel() async {
    try {
      await vision.loadYoloModel(
        labels: 'assets/labels.txt',
        modelPath: 'assets/yolov8s.tflite',
        modelVersion: 'yolov8',
        quantization: true,
        numThreads: 4,
        useGpu: true,
      );
      print('YOLO model loaded successfully');
    } catch (e) {
      print('Error loading YOLO model: $e');
    }
  }

  static void processCameraImage(
    CameraImage image,
    CameraController controller,
    Function() updateUI,
    bool isRecognitionEnabled,
    bool isTrafficLightRecognitionEnabled,
    bool isPedestrianRecognitionEnabled,
    Function() showPedestrianAlert,
    Function() playAlarm,
    Function() stopAlarm,
  ) async {
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

      bool trafficLightGreenDetected = false;
      bool trafficLightRedDetected = false;

      if (results.isNotEmpty && isRecognitionEnabled) {
        recognitions = results
            .map((result) {
              final label = result['tag'] ?? '';
              print('Recognition result: $result');
              if (!isTrafficLightRecognitionEnabled &&
                  (label == "trafficLight-Green" ||
                      label == "trafficLight-Red" ||
                      label == "trafficLight-Yellow")) {
                return null;
              }
              if (!isPedestrianRecognitionEnabled && label == "pedestrian") {
                return null;
              }

              final confidence = result['box'][4] ?? 0.0;

              final previewSize = controller.value.previewSize;
              final widthScale = previewSize!.width / image.width;
              final heightScale = previewSize.height / image.height;

              final x1 = result['box'][0] * widthScale;
              final y1 = result['box'][1] * heightScale;
              final x2 = result['box'][2] * widthScale;
              final y2 = result['box'][3] * heightScale;

              final rect = Rect.fromLTRB(x1, y1, x2, y2);

              // Trigger the alert if a pedestrian is detected and the alert has not been shown
              if (label == "pedestrian" && !isPedestrianAlertShown) {
                isPedestrianAlertShown = true;
                showPedestrianAlert();
              }

              // Trigger the alert if a traffic light is detected and the alert has not been shown
              if (label == "trafficLight-Green") {
                trafficLightGreenDetected = true;
                if (!isTrafficLightGreenAlertShown) {
                  isTrafficLightGreenAlertShown = true;
                  playAlarm();
                }
              }

              if (label == "trafficLight-Red") {
                trafficLightRedDetected = true;
                if (!isTrafficLightRedAlertShown) {
                  isTrafficLightRedAlertShown = true;
                  playAlarm();
                }
              }

              return Recognition(
                label: label,
                confidence: confidence,
                rect: rect,
              );
            })
            .where((element) => element != null)
            .cast<Recognition>()
            .toList();
      } else {
        recognitions = [];
        stopAlarm(); // Stop alarm if recognition is disabled or no results
        isPedestrianAlertShown = false;
        isTrafficLightGreenAlertShown = false;
        isTrafficLightRedAlertShown = false;
      }

      // Stop the alarm if no traffic lights are detected
      if (!trafficLightGreenDetected && !trafficLightRedDetected) {
        if (isTrafficLightGreenAlertShown || isTrafficLightRedAlertShown) {
          stopAlarm();
        }
        isTrafficLightGreenAlertShown = false;
        isTrafficLightRedAlertShown = false;
      }

      updateUI();
    } catch (e) {
      print('Error processing camera image: $e');
    } finally {
      isProcessing = false;
    }
  }

  static void resetPedestrianAlert() {
    isPedestrianAlertShown = false;
    isTrafficLightGreenAlertShown = false;
    isTrafficLightRedAlertShown = false;
  }

  static void resetAlerts() {
    isPedestrianAlertShown = false;
    isTrafficLightGreenAlertShown = false;
    isTrafficLightRedAlertShown = false;
    stopAlarm();
  }

  static void startAlarm() {
    if (!isAlarmPlaying) {
      alarmPlayer.Alarm(
        url: "assets/alert_sound.mp3",
        volume: 0.5,
        looping: true,
        callback: () {
          isAlarmPlaying = false;
        },
      );
      isAlarmPlaying = true;
    }
  }

  static void stopAlarm() {
    if (isAlarmPlaying) {
      alarmPlayer.StopAlarm();
      isAlarmPlaying = false;
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

  @override
  String toString() {
    return 'Recognition(label: $label, confidence: $confidence, rect: $rect)';
  }
}
