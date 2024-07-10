import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sound_mode/permission_handler.dart';
import 'package:sound_mode/sound_mode.dart';
import 'package:sound_mode/utils/ringer_mode_statuses.dart';
import 'package:alarmplayer/alarmplayer.dart';
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
    extends State<ObjectRecognitionMainPageScreen> with WidgetsBindingObserver {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  bool _isSilentMode = false;
  bool _isRecognitionEnabled = true;
  bool _isTrafficLightRecognitionEnabled = true;
  bool _isPedestrianRecognitionEnabled = true;
  String? _permissionStatus;
  Alarmplayer alarmplayer = Alarmplayer();
  bool playing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (widget.permissionGranted) {
      _initializeCamera();
      RecognitionLogic.loadModel();
    }
    _getPermissionStatus();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    RecognitionLogic.vision.closeYoloModel();
    alarmplayer.StopAlarm();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _getPermissionStatus();
    }
  }

  void _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final firstCamera = cameras.first;
      _controller = CameraController(
        firstCamera,
        ResolutionPreset.ultraHigh,
      );
      _initializeControllerFuture = _controller!.initialize().then((_) {
        if (mounted) {
          setState(() {});
          _controller?.startImageStream((image) {
            if (!RecognitionLogic.isProcessing) {
              RecognitionLogic.processCameraImage(
                image,
                _controller!,
                () {
                  setState(() {});
                },
                _isRecognitionEnabled,
                _isTrafficLightRecognitionEnabled,
                _isPedestrianRecognitionEnabled,
                _showPedestrianAlert, // Pass the callback function
              );
            }
          });
        }
      });
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  void _getPermissionStatus() async {
    bool? permissionStatus = false;
    try {
      permissionStatus = await PermissionHandler.permissionsGranted;
      print(permissionStatus);
    } catch (err) {
      print(err);
    }

    setState(() {
      _permissionStatus =
          permissionStatus! ? "Permissions Enabled" : "Permissions not granted";
    });
  }

  Future<void> _requestDoNotDisturbPermission() async {
    await PermissionHandler.openDoNotDisturbSetting();
  }

  void _toggleSilentMode() async {
    if (_permissionStatus == "Permissions not granted") {
      await _requestDoNotDisturbPermission();
      return;
    }

    bool isSilent = !_isSilentMode;

    try {
      if (isSilent) {
        await SoundMode.setSoundMode(RingerModeStatus.silent);
      } else {
        await SoundMode.setSoundMode(RingerModeStatus.normal);
      }

      setState(() {
        _isSilentMode = isSilent;
      });

      if (isSilent) {
        _showSilentModeDialog();
      }
    } on PlatformException {
      print('Do Not Disturb access permissions required!');
    }
  }

  void _showSilentModeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pop(true);
        });
        return AlertDialog(
          title: Text("Silent Mode"),
          content: Text("Silent mode enabled"),
        );
      },
    );
  }

  void _showPedestrianAlert() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Pedestrian Detected",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              Text(
                "A pedestrian has been detected.",
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  alarmplayer.StopAlarm();
                  Navigator.of(context).pop();
                  RecognitionLogic
                      .resetPedestrianAlert(); // Reset the alert flag
                },
                child: Text("OK"),
              ),
            ],
          ),
        );
      },
    );

    alarmplayer.Alarm(
      url:
          "assets/alert_sound.mp3", // Ensure this file is in your assets folder
      volume: 0.5,
      looping: true,
    );
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
        RecognitionOverlay(
          controller: _controller!,
          isRecognitionEnabled: _isRecognitionEnabled,
          isTrafficLightRecognitionEnabled: _isTrafficLightRecognitionEnabled,
          isPedestrianRecognitionEnabled: _isPedestrianRecognitionEnabled,
        ),
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
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isRecognitionEnabled = !_isRecognitionEnabled;
                });
              },
              child: Container(
                margin: EdgeInsets.only(right: 20.0),
                child: Image(
                  image: AssetImage(
                    _isRecognitionEnabled
                        ? 'assets/images/object_detection_icon.png'
                        : 'assets/images/object_detection_disable_icon.png',
                  ),
                  height: 80.0,
                  width: 80.0,
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isTrafficLightRecognitionEnabled =
                      !_isTrafficLightRecognitionEnabled;
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Image(
                  image: AssetImage(
                    _isTrafficLightRecognitionEnabled
                        ? 'assets/images/traffic_light_icon.png'
                        : 'assets/images/traffic_light_disable_icon.png',
                  ),
                  height: 80.0,
                  width: 80.0,
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isPedestrianRecognitionEnabled =
                      !_isPedestrianRecognitionEnabled;
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Image(
                  image: AssetImage(
                    _isPedestrianRecognitionEnabled
                        ? 'assets/images/warning_icon.png'
                        : 'assets/images/warning_disable_icon.png', // Add a disabled icon
                  ),
                  height: 80.0,
                  width: 80.0,
                ),
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
