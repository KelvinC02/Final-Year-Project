import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'recognition_logic.dart';

class RecognitionOverlay extends StatelessWidget {
  final CameraController controller;

  RecognitionOverlay({required this.controller});

  @override
  Widget build(BuildContext context) {
    if (RecognitionLogic.recognitions.isEmpty) {
      print('No recognitions found');
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
          children: RecognitionLogic.recognitions.map((recog) {
            var box = recog.rect;
            var tag;
            if (recog.label == "car" || recog.label == "truck") {
              tag = "obstacles";
            } else {
              tag = recog.label;
            }
            var confidence = recog.confidence;

            // Adjust the box coordinates based on the scale
            var left = box.left * scaleX;
            var top = box.top * scaleY;
            var width = box.width * scaleX;
            var height = box.height * scaleY;

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
                    fontSize: 15,
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
