import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import '../core/app_export.dart';
import '../model_recognition/recognition_logic.dart';
import '../model_recognition/recognition_overlay.dart';

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

  @override
  void initState() {
    super.initState();
    if (widget.permissionGranted) {
      _initializeCamera();
      RecognitionLogic.loadModel();
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
            if (!RecognitionLogic.isProcessing) {
              RecognitionLogic.processCameraImage(image, _controller!, () {
                setState(() {});
              });
            }
          });
        }
      });
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    RecognitionLogic.vision.closeYoloModel();
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
        RecognitionOverlay(controller: _controller!),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _buildInboxImages1(context),
            SizedBox(height: 15),
            Expanded(
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
            SizedBox(height: 15),
            _buildInboxImages2(context),
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
      print('Silent mode enabled');
    } else {
      print('Silent mode disabled');
    }
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
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
              Navigator.pushNamed(context, AppRoutes.mainPageScreen);
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
              await _pickImage();
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
