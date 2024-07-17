import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'recognition_logic.dart';

class RecognitionOverlay extends StatelessWidget {
  final CameraController controller;
  final bool isRecognitionEnabled;
  final bool isTrafficLightRecognitionEnabled;
  final bool isPedestrianRecognitionEnabled;

  RecognitionOverlay({
    required this.controller,
    required this.isRecognitionEnabled,
    required this.isTrafficLightRecognitionEnabled,
    required this.isPedestrianRecognitionEnabled,
  });

  @override
  Widget build(BuildContext context) {
    if (!isRecognitionEnabled || RecognitionLogic.recognitions.isEmpty) {
      print('No recognitions found or recognition disabled');
      return Container();
    }

    print(
        'Building overlay with recognitions: ${RecognitionLogic.recognitions}');

    return LayoutBuilder(
      builder: (context, constraints) {
        var screenWidth = constraints.maxWidth;
        var screenHeight = constraints.maxHeight;

        var previewWidth = controller.value.previewSize!.height;
        var previewHeight = controller.value.previewSize!.width;

        var screenRatio = screenWidth / screenHeight;
        var previewRatio = previewWidth / previewHeight;

        double scaleX, scaleY;
        if (screenRatio > previewRatio) {
          scaleX = screenWidth / previewWidth;
          scaleY = scaleX;
        } else {
          scaleY = screenHeight / previewHeight;
          scaleX = scaleY;
        }

        return Stack(
          children: RecognitionLogic.recognitions.where((recog) {
            if (!isTrafficLightRecognitionEnabled &&
                (recog.label == "trafficLight-Green" ||
                    recog.label == "trafficLight-Yellow" ||
                    recog.label == "trafficLight-Red")) {
              return false;
            }
            if (!isPedestrianRecognitionEnabled &&
                recog.label == "pedestrian") {
              return false;
            }
            return true;
          }).map((recog) {
            var box = recog.rect;
            var tag = recog.label == "car" || recog.label == "truck"
                ? "obstacles"
                : recog.label;
            var confidence = recog.confidence;

            var left = box.left * scaleX;
            var top = (box.top * scaleY) - 30;
            var width = box.width * scaleX;
            var height = (box.height * scaleY) - 15;

            print('Drawing box at $left, $top, width: $width, height: $height');

            return Positioned(
              left: left,
              top: top,
              width: width,
              height: height,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red,
                    width: 2,
                  ),
                ),
                child: Text(
                  "$tag ${(confidence * 100).toStringAsFixed(0)}%",
                  style: TextStyle(
                    background: Paint()..color = Colors.red,
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
