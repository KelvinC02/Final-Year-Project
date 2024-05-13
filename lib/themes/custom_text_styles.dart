import 'package:flutter/material.dart';
import '../core/app_export.dart';

extension on TextStyle {
  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }

  TextStyle get urbanist {
    return copyWith(
      fontFamily: 'Urbanist',
    );
  }

  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }
}

class CustomTextStyles {
  static get displayMediumOnPrimary => theme.textTheme.displayMedium!.copyWith(
        color: theme.colorScheme.onPrimary,
      );

  static get headlineLargePoppinsGrey900 =>
      theme.textTheme.headlineLarge!.poppins.copyWith(
        color: appTheme.grey900,
        fontSize: 33,
        fontWeight: FontWeight.w700,
      );

  static get headlineLargePoppinsGrey900Bold =>
      theme.textTheme.headlineLarge!.poppins.copyWith(
        color: appTheme.grey900,
        fontWeight: FontWeight.w700,
      );

  static get headlineLargeUrbanist =>
      theme.textTheme.headlineLarge!.urbanist.copyWith(
        fontWeight: FontWeight.w700,
      );

  static get headlineSmallInterBlack900 =>
      theme.textTheme.headlineSmall!.inter.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w400,
      );

  static get headlineSmallInterBlack900_1 =>
      theme.textTheme.headlineSmall!.inter.copyWith(
        color: appTheme.black900,
      );

  static get labelLargeBlack900 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w700,
      );

  static get labelLargeErrorContainer => theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.errorContainer,
        fontWeight: FontWeight.w500,
      );

  static get titleLargeBold => theme.textTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.w700,
      );

  static get titleMediumGrey400 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.grey400,
        fontSize: 17,
      );

  static get titleMediumOnPrimaryContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      );

  static get titleMediumPoppinsBluegrey10002 =>
      theme.textTheme.titleMedium!.poppins.copyWith(
        color: appTheme.blueGrey10002,
        fontWeight: FontWeight.w600,
      );

  static get titleSmallIndigo500 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.indigo500,
      );
}
