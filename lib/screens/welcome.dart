import 'package:DriveVue/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import '../core/app_export.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 27.h,
            vertical: 98.v,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 55.v,
              ),
              SizedBox(
                width: 300.h,
                child: (Image.asset('assets/images/app_logo.png')),
              ),
              Spacer(
                flex: 46,
              ),
              SizedBox(
                width: 212.h,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Welcome to \n",
                        style: theme.textTheme.displayMedium,
                      ),
                      TextSpan(
                        text: "DriveVue",
                        style: CustomTextStyles.displayMediumOnPrimary,
                      )
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Spacer(
                flex: 53,
              ),
              CustomElevatedButton(
                text: "Get Started with Tutorial",
                onPressed: () {
                  onTapGetStarted(context);
                },
                buttonStyle: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
              ),
              SizedBox(
                height: 22.v,
              ),
              CustomElevatedButton(
                text: "Not First Time? Skip Tutorial",
                buttonStyle: CustomButtonStyles.fillGrey,
                buttonTextStyle: CustomTextStyles.titleMediumGrey400,
                onPressed: () {
                  onTapNotFirstTime(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  onTapGetStarted(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.tutorialMainPageScreen);
  }

  onTapNotFirstTime(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.mainPageScreen);
  }
}
