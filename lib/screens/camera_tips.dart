import 'package:DriveVue/widgets/appbar/appbar_subtitle.dart';
import 'package:DriveVue/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import '../core/app_export.dart';

class CameraTipsScreen extends StatelessWidget {
  const CameraTipsScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              vertical: 33.v,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 18.v,
                ),
                Container(
                  width: 293.h,
                  margin: EdgeInsets.only(
                    left: 27.h,
                    right: 39.h,
                  ),
                  child: Text(
                    "It is good to know that you are ready for our app! Here some tips on placing your camera:",
                    overflow: TextOverflow.visible,
                    style: CustomTextStyles.titleLargeBold,
                  ),
                ),
                SizedBox(
                  height: 38.v,
                ),
                Image(
                  image: AssetImage(
                    'assets/images/placing_camera_tips.png',
                  ),
                  height: 230.v,
                  width: 350.h,
                ),
                SizedBox(
                  height: 46.v,
                ),
                Container(
                  width: 306.h,
                  margin: EdgeInsets.symmetric(
                    horizontal: 27.h,
                  ),
                  child: Text(
                    "It is always advisable to install your camera at the center of the windshield for better performance. "
                    "It can be either using a phone holder or at the rear-view mirror.",
                    overflow: TextOverflow.visible,
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                SizedBox(
                  height: 35.v,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.only(
                      right: 26.h,
                    ),
                    child: CustomOutlinedButton(
                      width: 125.h,
                      text: "OK, I understand",
                      onPressed: () {
                        onTapOKUnderstand(context);
                      },
                    ),
                  ),
                ),
              ],
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

  void onTapOKUnderstand(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.mainPageScreen);
  }
}
