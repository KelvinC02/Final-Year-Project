import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../widgets/appbar/appbar_subtitle_one.dart';
import '../widgets/custom_appbar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPgTwoScreen extends StatelessWidget {
  const OnBoardingPgTwoScreen({Key? key})
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
          horizontal: 13.h,
          vertical: 20.v,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 5.v,
            ),
            SizedBox(
              width: 177.h,
              child: Image.asset(
                  'assets/images/image_of_traffic_light_recognition.png'),
            ),
            SizedBox(
              height: 20.v,
            ),
            SizedBox(
              height: 17.v,
              child: AnimatedSmoothIndicator(
                activeIndex: 1,
                count: 3,
                effect: ScrollingDotsEffect(
                  spacing: 12.01,
                  activeDotColor: theme.colorScheme.onPrimary,
                  dotColor: appTheme.grey9007f,
                  activeDotScale: 1.888888888888,
                  dotHeight: 9.v,
                  dotWidth: 9.h,
                ),
              ),
            ),
            SizedBox(
              height: 26.v,
            ),
            Container(
              width: 321.h,
              margin: EdgeInsets.only(
                left: 9.h,
                right: 2.h,
              ),
              child: AutoSizeText(
                "Traffic Light Recognition Features",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: CustomTextStyles.headlineLargePoppinsGrey900.copyWith(
                  height: 1.50,
                ),
              ),
            ),
            SizedBox(
              height: 10.v,
            ),
            Flexible(
              child: AutoSizeText(
                "Stay safe and get informed on the road with our traffic light recognition feature. Whether driving or walking, we'll alert you to traffic lights ahead, ensuring you're always aware and can navigate intersections confidently.",
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge,
                minFontSize: 12,
              ),
            ),
            SizedBox(
              height: 10.v,
            ),
            FractionallySizedBox(
              widthFactor: 0.5,
              child: Container(
                // margin: EdgeInsets.symmetric(horizontal: 89.h),
                padding: EdgeInsets.all(15.h),
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
                      height: 24.v,
                      child: VerticalDivider(
                        width: 2.h,
                        thickness: 2.h,
                        color: appTheme.grey200,
                      ),
                    ),
                    Spacer(
                      flex: 50,
                    ),
                    IconButton(
                      onPressed: () => onRightTap(context),
                      icon: Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      actions: [
        AppbarSubtitleOne(
          text: "Skip",
          margin: EdgeInsets.symmetric(
            horizontal: 43.h,
            vertical: 14.v,
          ),
          onTap: () {
            onTapSkip(context);
          },
        )
      ],
    );
  }

  onLeftTap(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.onBoardingPgOneScreen);
  }

  onRightTap(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.onBoardingPgThreeScreen);
  }

  onTapSkip(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.tncScreen);
  }
}
