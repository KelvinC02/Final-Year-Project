import 'package:DriveVue/themes/custom_text_styles.dart';
import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPgOneScreen extends StatelessWidget {
  const OnBoardingPgOneScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      //appBar: _buildAppBar(context),
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 70,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 9,
            ),
            SizedBox(
                width: 250,
                child: Image.asset(
                    'assets/images/image_of_object_recognition.png')),
            Spacer(),
            SizedBox(
              height: 17,
              child: AnimatedSmoothIndicator(
                activeIndex: 0,
                count: 3,
                effect: ScrollingDotsEffect(
                  spacing: 12.01,
                  activeDotColor: theme.colorScheme.onPrimary,
                  dotColor: appTheme.grey9007f,
                  activeDotScale: 1.888888888888,
                  dotHeight: 9,
                  dotWidth: 9,
                ),
              ),
            ),
            SizedBox(
              height: 26,
            ),
            Container(
              width: 321,
              margin: EdgeInsets.only(
                left: 9,
                right: 2,
              ),
              child: Text(
                "Object Recognition Features",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: CustomTextStyles.headlineLargePoppinsGrey900.copyWith(
                  height: 1.50,
                ),
              ),
            ),
            Spacer(),
            Text(
              "Effortlessly identify objects around you using our advanced recognition technology. Simply point your device, and we'll provide instant information about the objects in view, making everyday tasks easier and more accessible.",
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge,
            ),
            SizedBox(
              height: 34,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 89),
              padding: EdgeInsets.all(20),
              decoration: AppDecoration.outlineOnErrorContainer.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => onLeftTap(context),
                    icon: Icon(Icons.arrow_back),
                  ),
                  Spacer(
                    flex: 50,
                  ),
                  SizedBox(
                    height: 24,
                    child: VerticalDivider(
                      width: 2,
                      thickness: 2,
                      color: appTheme.grey200,
                    ),
                  ),
                  Spacer(
                    flex: 50,
                  ),
                  IconButton(
                    onPressed: () => onRightTap(context),
                    icon: Icon(Icons.arrow_forward),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  onLeftTap(BuildContext context) {}

  onRightTap(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.onBoardingPgTwoScreen);
  }
}
