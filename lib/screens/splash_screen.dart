import 'package:flutter/material.dart';
import '../core/app_export.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.onBoardingPgOneScreen);
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(vertical: 35.v),
            child: Column(
              children: [
                Spacer(flex: 37),
                SizedBox(
                  child: Image.asset('assets/images/app_logo.png'),
                ),
                Spacer(flex: 40),
                Text(
                  "Tap anywhere to continue",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                Spacer(flex: 20),
                Spacer(flex: 37),
                Column(
                  children: [
                    Text(
                      "DriveVue",
                      style: theme.textTheme.displaySmall,
                    ),
                    Text(
                      "Version 1.0",
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
