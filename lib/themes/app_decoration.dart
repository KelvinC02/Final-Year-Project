import 'package:flutter/material.dart';
import '../core/app_export.dart';

class AppDecoration {
  static BoxDecoration get fillBlueGrey => BoxDecoration(
        color: appTheme.blueGrey10001,
      );

  static BoxDecoration get fillIndigo => BoxDecoration(
        color: appTheme.indigo500.withOpacity(0.25),
      );

  static BoxDecoration get fillOnPrimaryContainer => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer,
      );

  static BoxDecoration get outlineOnErrorContainer => BoxDecoration(
        color: appTheme.grey50,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.onErrorContainer,
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(
              0,
              40,
            ),
          )
        ],
      );
}

class BorderRadiusStyle {
  static BorderRadius get roundedBorder16 => BorderRadius.circular(
        16,
      );
}
