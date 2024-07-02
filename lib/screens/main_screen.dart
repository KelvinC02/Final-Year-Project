import 'package:DriveVue/screens/object_recognition_main.dart';
import 'package:DriveVue/widgets/appbar/appbar_subtitle.dart';
import 'package:DriveVue/widgets/custom_appbar.dart';
import 'package:DriveVue/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../core/app_export.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 27.h,
            vertical: 38.v,
          ),
          child: Column(
            children: [
              Container(
                width: 300.h,
                margin: EdgeInsets.only(
                  right: 5.h,
                ),
                child: Text(
                  "Welcome to DriveVue - An Application Designed for Object Recognition in Autonomous Vehicle",
                  overflow: TextOverflow.visible,
                  style: theme.textTheme.titleLarge,
                ),
              ),
              SizedBox(
                height: 42.v,
              ),
              GestureDetector(
                onTap: () {
                  onTapColumnCamera(context);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 11.h,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 69.h,
                    vertical: 82.v,
                  ),
                  decoration: AppDecoration.fillBlueGrey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 6.v,
                      ),
                      Image(
                        image: AssetImage('assets/images/camera_icon.png'),
                        height: 48.v,
                        width: 74.h,
                      ),
                      SizedBox(
                        height: 33.v,
                      ),
                      Text(
                        "Start Recognition",
                        style: theme.textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 97.v,
              ),
              CustomElevatedButton(
                text: "Tips on Placing Camera",
                onPressed: () {
                  onTipsPlacingCamera(context);
                },
                buttonStyle: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
              ),
              SizedBox(
                height: 5.v,
              ),
            ],
          ),
        ),
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

  void onTapColumnCamera(BuildContext context) async {
    try {
      print("Camera button tapped"); // Debug print
      PermissionStatus status = await Permission.camera.request();
      print("Camera permission status: ${status.isGranted}"); // Debug print

      if (status.isGranted || status.isDenied) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ObjectRecognitionMainPageScreen(
                permissionGranted: status.isGranted),
          ),
        );
      }
    } catch (e) {
      print("Error requesting camera permission: $e");
    }
  }

  onTipsPlacingCamera(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.tipsOnPlacingCameraScreen);
  }
}
