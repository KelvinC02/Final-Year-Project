import 'package:DriveVue/widgets/appbar/appbar_subtitle.dart';
import 'package:DriveVue/widgets/custom_appbar.dart';
import 'package:DriveVue/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import '../core/app_export.dart';

class TutorialEndScreen extends StatelessWidget {
  const TutorialEndScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 22.h,
            vertical: 94.v,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/images/hooray.png'),
                height: 200.v,
                width: 315.h,
              ),
              SizedBox(
                height: 58.v,
              ),
              Container(
                width: 291.h,
                margin: EdgeInsets.only(
                  left: 5.h,
                  right: 19.h,
                ),
                child: Text(
                  "Congratulations! You have completed our Tutorial. Let get started!",
                  overflow: TextOverflow.visible,
                  style: theme.textTheme.titleLarge,
                ),
              ),
              Spacer(),
              CustomElevatedButton(
                text: "Head to Main Page",
                margin: EdgeInsets.symmetric(
                  horizontal: 5.h,
                ),
                onPressed: () {
                  onTapHeadToMain(context);
                },
                buttonStyle: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
              ),
              SizedBox(
                height: 22.v,
              ),
              CustomElevatedButton(
                text: "Replay Tutorial",
                margin: EdgeInsets.symmetric(
                  horizontal: 5.h,
                ),
                buttonStyle: CustomButtonStyles.fillGrey,
                buttonTextStyle: CustomTextStyles.titleMediumGrey400,
                onPressed: () {
                  onTapReplayTutorial(context);
                },
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

  onTapHeadToMain(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.mainPageScreen);
  }

  onTapReplayTutorial(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.tutorialMainPageScreen);
  }
}
