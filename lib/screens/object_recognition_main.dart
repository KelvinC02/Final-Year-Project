import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../core/app_export.dart';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:image_picker/image_picker.dart';

FlutterVision vision = FlutterVision();

class ObjectRecognitionMainPageScreen extends StatefulWidget {
  final bool permissionGranted;

  const ObjectRecognitionMainPageScreen(
      {Key? key, required this.permissionGranted})
      : super(key: key);

  @override
  _ObjectRecognitionMainPageScreenState createState() =>
      _ObjectRecognitionMainPageScreenState();
}

class _ObjectRecognitionMainPageScreenState
    extends State<ObjectRecognitionMainPageScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  List<Recognition> _recognitions = []; // Initialize as an empty list
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    if (widget.permissionGranted) {
      _initializeCamera();
      _loadModel();
    }
  }

  void _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final firstCamera = cameras.first;
      _controller = CameraController(
        firstCamera,
        ResolutionPreset.high,
      );
      _initializeControllerFuture = _controller!.initialize().then((_) {
        if (mounted) {
          setState(() {});
          _controller?.startImageStream((image) {
            if (!_isProcessing) {
              _isProcessing = true;
              _processCameraImage(image);
            }
          });
        }
      });
      print('Camera initialized successfully');
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  Future<void> _loadModel() async {
    try {
      await vision.loadYoloModel(
        labels: 'assets/labels.txt',
        modelPath: 'assets/yolov8s.tflite',
        modelVersion: 'yolov8',
        quantization: false,
        numThreads: 1,
        useGpu: false,
      );
      print('YOLO model loaded successfully');
    } catch (e) {
      print('Error loading YOLO model: $e');
    }
  }

  void _processCameraImage(CameraImage image) async {
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
        print('Recognition results: $results');
        setState(() {
          _recognitions = results.map((result) {
            final label = result['tag'] ?? '';
            final confidence = result['box'][4] ?? 0.0;

            // Map the bounding box coordinates back to the original image dimensions
            final x1 = result['box'][0] * image.width / 800;
            final y1 = result['box'][1] * image.height / 800;
            final x2 = result['box'][2] * image.width / 800;
            final y2 = result['box'][3] * image.height / 800;

            final rect = Rect.fromLTRB(x1, y1, x2, y2);

            return Recognition(
              label: label,
              confidence: confidence,
              rect: rect,
            );
          }).toList();
        });
      } else {
        print('No object detected');
        setState(() {
          _recognitions = [];
        });
      }
    } catch (e) {
      print('Error processing camera image: $e');
    } finally {
      _isProcessing = false; // Reset the flag
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    vision.closeYoloModel();
    super.dispose();
  }

  Widget _buildCameraPreview() {
    if (_controller == null || !_controller!.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }

    return Stack(
      children: [
        Positioned.fill(
          child: AspectRatio(
            aspectRatio: _controller!.value.aspectRatio,
            child: CameraPreview(_controller!),
          ),
        ),
        _buildRecognitionOverlay(),
      ],
    );
  }

  Widget _buildRecognitionOverlay() {
    if (_recognitions.isEmpty) return Container();

    return LayoutBuilder(
      builder: (context, constraints) {
        var screenWidth = constraints.maxWidth;
        var screenHeight = constraints.maxHeight;

        var previewWidth = _controller!.value.previewSize!.height;
        var previewHeight = _controller!.value.previewSize!.width;

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

        print('Screen size: $screenWidth x $screenHeight');
        print('Preview size: $previewWidth x $previewHeight');
        print('Scale factors: scaleX=$scaleX, scaleY=$scaleY');

        return Stack(
          children: _recognitions.map((recog) {
            var box = recog.rect;
            var tag;
            if (recog.label == "car" || recog.label == "truck") {
              tag = "obstacles";
            }
            var confidence = recog.confidence;

            // Adjust the box coordinates based on the scale
            var left = box.left * scaleX;
            var top = box.top * scaleY;
            var width = box.width * scaleX;
            var height = box.height * scaleY;

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: widget.permissionGranted
                  ? FutureBuilder<void>(
                      future: _initializeControllerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return _buildCameraPreview();
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    )
                  : Center(
                      child: Text(
                        'Permission Denied',
                        style: TextStyle(fontSize: 24.0, color: Colors.red),
                      ),
                    ),
            ),
            Column(
              children: [
                _buildInboxImages1(context), // Top row of icons
                Expanded(
                  child: Container(), // Empty container to fill space
                ),
                _buildInboxImages2(context), // Bottom row of icons
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInboxImages1(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 20.0),
              child: Image(
                image: AssetImage('assets/images/object_detection_icon.png'),
                height: 80.0,
                width: 80.0,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Image(
                image: AssetImage('assets/images/traffic_light_icon.png'),
                height: 80.0,
                width: 80.0,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Image(
                image: AssetImage('assets/images/warning_icon.png'),
                height: 80.0,
                width: 80.0,
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: _toggleSilentMode,
              child: Container(
                margin: EdgeInsets.only(left: 20.0),
                child: Image(
                  image: AssetImage(
                    _isSilentMode
                        ? 'assets/images/silent_icon.png'
                        : 'assets/images/bell_icon.png',
                  ),
                  height: 80.0,
                  width: 80.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isSilentMode = false;

  void _toggleSilentMode() {
    setState(() {
      _isSilentMode = !_isSilentMode;
    });
    if (_isSilentMode) {
      // Mute all notifications
      // You might need to use platform-specific code to actually mute notifications
      print('Silent mode enabled');
    } else {
      // Unmute notifications
      // You might need to use platform-specific code to actually unmute notifications
      print('Silent mode disabled');
    }
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Do something with the picked file, e.g., display it in an Image widget
      print('Picked file path: ${pickedFile.path}');
    }
  }

  Widget _buildInboxImages2(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 14.0, right: 20.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context,
                  AppRoutes.mainPageScreen); // Navigate back to previous screen
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 9.0),
              child: Image(
                image: AssetImage('assets/images/return_icon.png'),
                height: 40.0,
                width: 40.0,
              ),
            ),
          ),
          Spacer(flex: 51),
          Image(
            image: AssetImage('assets/images/capture_icon.png'),
            height: 58.0,
            width: 58.0,
          ),
          Spacer(flex: 48),
          GestureDetector(
            onTap: () async {
              await _pickImage(); // Open the gallery to pick an image
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 9.0),
              child: Image(
                image: AssetImage('assets/images/gallery_icon.png'),
                height: 40.0,
                width: 40.0,
              ),
            ),
          ),
        ],
      ),
    );
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
