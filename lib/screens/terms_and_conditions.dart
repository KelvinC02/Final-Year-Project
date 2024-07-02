import 'package:DriveVue/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import '../core/app_export.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          // Wrap with SingleChildScrollView
          scrollDirection: Axis.vertical, // Set scroll direction to vertical
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal: 30.h,
              vertical: 36.h,
            ),
            child: Column(
              children: [
                Text(
                  "Terms and Conditions",
                  style: CustomTextStyles.headlineSmallInterBlack900_1,
                ),
                SizedBox(
                  height: 29.v,
                ),
                SizedBox(
                  width: 297.h,
                  child: Text(
                    "Welcome to DriveVue! By accessing or using our services, you agree to be bound by the following Terms and Conditions. If you do not agree with any part of these terms, you may not access or use our services. "
                    "Our Object Recognition feature allows users to identify objects around them, although accuracy cannot be guaranteed for all objects. Users are responsible for verifying the information provided. "
                    "Similarly, our Traffic Light Recognition feature alerts users to traffic lights ahead; however, users must adhere to traffic laws and exercise caution. DriveVue is not liable for accidents resulting from the use of this feature. "
                    "Additionally, our Sound-Based Warning feature provides audible alerts for nearby pedestrians, but users should remain attentive and cautious. We respect your privacy and protect your personal information as outlined in our Privacy Policy. "
                    "We reserve the right to modify these Terms and Conditions at any time without notice. For questions or concerns, please contact us at 20054235@imail.sunway.edu.my. "
                    "\n\nPlease note that DriveVue is developed for the usage for Final Year Project under Bachelor of Software Engineering with Honours."
                    "\n\nBy using DriveVue, you acknowledge that you have read, understood, and agree to be bound by these Terms and Conditions.",
                  ),
                ),
                SizedBox(
                  height: 5.v,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildValidationSection(context),
      ),
    );
  }

  Widget _buildValidationSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 8.h,
        right: 8.h,
        bottom: 26.v,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CustomElevatedButton(
              height: 57.v,
              text: "Decline".toUpperCase(),
              margin: EdgeInsets.only(right: 7.h),
              buttonStyle: CustomButtonStyles.fillRed,
              buttonTextStyle: theme.textTheme.titleSmall,
              onPressed: () {
                onTapDecline(context);
              },
            ),
          ),
          Expanded(
            child: CustomElevatedButton(
              height: 57.v,
              text: "Accept".toUpperCase(),
              margin: EdgeInsets.only(left: 7.h),
              buttonStyle: CustomButtonStyles.fillIndigo,
              buttonTextStyle: CustomTextStyles.titleSmallIndigo500,
              onPressed: () {
                onTapAccept(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  onTapDecline(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.splashscreenScreen);
  }

  onTapAccept(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.welcomeScreen);
  }
}
