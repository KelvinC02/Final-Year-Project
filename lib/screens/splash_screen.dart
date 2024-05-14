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
                Spacer(
                  flex: 37,
                ),
                SizedBox(
                  child: (Image.asset('assets/images/app_logo.png')),
                ),
                Spacer(
                  flex: 62,
                ),
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
          ),
        ),
      ),
    );
  }
}

// import 'dart:async';
// import 'package:flutter/material.dart';
// import '../core/app_export.dart';
// import 'on_boarding_pg_one.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Delay navigation by 3 seconds (3000 milliseconds)
//     Timer(
//       Duration(seconds: 3),
//       () {
//         Navigator.pushNamed(context, AppRoutes.onBoardingPgOneScreen);
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: Container(
//           width: double.maxFinite,
//           padding: EdgeInsets.symmetric(vertical: 35.v),
//           child: Column(
//             children: [
//               Spacer(flex: 37),
//               SizedBox(
//                 child: Image.asset('assets/images/app_logo.png'),
//               ),
//               Spacer(flex: 62),
//               Text(
//                 "DriveVue",
//                 style: theme.textTheme.displaySmall,
//               ),
//               Text(
//                 "Version 1.0",
//                 style: theme.textTheme.bodyMedium,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
