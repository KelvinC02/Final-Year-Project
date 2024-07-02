import 'package:DriveVue/widgets/appbar/appbar_subtitle.dart';
import 'package:DriveVue/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import '../core/app_export.dart';

class TutorialObjectRecognitionMainPageScreen extends StatelessWidget {
  const TutorialObjectRecognitionMainPageScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.tutorialEndScreen);
          },
          child: Center(
            child: AspectRatio(
              aspectRatio: 331 / 671,
              child: Image.asset(
                'assets/images/tutorial_object_recognition_screen.png',
                fit: BoxFit.contain,
              ),
            ),
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
}
