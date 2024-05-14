import 'package:DriveVue/screens/on_boarding_pg_one.dart';
import 'package:flutter/material.dart';
import '../core/app_export.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(vertical: 35.v),
        child: Column(
          children: [
            Spacer(
              flex: 37,
            ),
            SizedBox(
              child: (Image.asset('assets/images/app_logo.jpeg')),
            ),
            Spacer(
              flex: 62,
            ),
            Text(
              "DriveVue",
            ),
            Text(
              "Version 1.0",
            ),
          ],
        ),
      ),
    ));
  }
}
