import 'package:DriveVue/widgets/appbar/appbar_subtitle.dart';
import 'package:DriveVue/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import '../core/app_export.dart';

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
    }
  }

  void _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _controller = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller!.initialize();
    if (mounted) {
      setState(() {}); // Update the UI after initializing the controller
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Widget _buildCameraPreview() {
    if (_controller == null || !_controller!.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }

    return Positioned.fill(
      top: MediaQuery.of(context).size.height *
          0.10, // Adjust top position as needed
      bottom: MediaQuery.of(context).size.height *
          0.15, // Adjust bottom position as needed
      child: Container(
        child: CameraPreview(_controller!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Stack(
          children: [
            // Camera preview or Permission Denied message
            widget.permissionGranted
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
            // Other widgets
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _buildInboxImages1(context),
            ),
            Positioned(
              bottom: 20.0,
              left: 0,
              right: 0,
              child: _buildInboxImages2(context),
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
            child: Container(
              margin: EdgeInsets.only(left: 20.0),
              child: Image(
                image: AssetImage('assets/images/silent_icon.png'),
                height: 80.0,
                width: 80.0,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInboxImages2(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 14.0, right: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 9.0),
            child: Image(
              image: AssetImage('assets/images/return_icon.png'),
              height: 40.0,
              width: 40.0,
            ),
          ),
          Spacer(flex: 51),
          Image(
            image: AssetImage('assets/images/capture_icon.png'),
            height: 58.0,
            width: 58.0,
          ),
          Spacer(flex: 48),
          Container(
            margin: EdgeInsets.symmetric(vertical: 9.0),
            child: Image(
              image: AssetImage('assets/images/gallery_icon.png'),
              height: 40.0,
              width: 40.0,
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      title: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 15.h,
              right: 130.h,
            ),
            child: Row(
              children: [
                Flexible(
                  child: Image(
                    image: AssetImage('assets/images/app_logo.png'),
                    height: kToolbarHeight,
                  ),
                ),
                SizedBox(
                  width: 20.h,
                ),
                Expanded(
                  child: AppbarSubtitle(
                    text: "DriveVue",
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
      styleType: Style.bgFill,
    );
  }
}
