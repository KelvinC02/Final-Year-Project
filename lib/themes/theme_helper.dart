import 'package:flutter/material.dart';
import '../core/app_export.dart';

String _appTheme = "lightCode";

LightCodeColors get appTheme => ThemeHelper().themeColor();

ThemeData get theme => ThemeHelper().themeData();

class ThemeHelper {
  Map<String, LightCodeColors> _supportedCustomColor = {
    'lightCode': LightCodeColors()
  };

  Map<String, ColorScheme> _supportedColorScheme = {
    'lightCode': ColorSchemes.lightCodeColorScheme
  };

  void changeTheme(String _newTheme) {
    _appTheme = _newTheme;
  }

  LightCodeColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? LightCodeColors();
  }

  ThemeData _getThemeData() {
    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.lightCodeColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      scaffoldBackgroundColor: colorScheme.onPrimaryContainer,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          shadowColor: colorScheme.primary,
          elevation: 8,
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          side: BorderSide(
            color: appTheme.blueGrey100,
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      dividerTheme: DividerThemeData(
        thickness: 53,
        space: 53,
        color: appTheme.redA700,
      ),
    );
  }

  LightCodeColors themeColor() => _getThemeColors();

  ThemeData themeData() => _getThemeData();
}

class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodyLarge: TextStyle(
          color: colorScheme.onError,
          fontSize: 16,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w300,
        ),
        bodyMedium: TextStyle(
          color: appTheme.grey600,
          fontSize: 14,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w300,
        ),
        bodySmall: TextStyle(
          color: appTheme.black900,
          fontSize: 10,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
        displayMedium: TextStyle(
          color: colorScheme.onSecondaryContainer,
          fontSize: 40,
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w700,
        ),
        displaySmall: TextStyle(
          color: appTheme.black900,
          fontSize: 35,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
        headlineLarge: TextStyle(
          color: appTheme.black900,
          fontSize: 32,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
        headlineSmall: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 24,
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w700,
        ),
        labelLarge: TextStyle(
          color: colorScheme.primaryContainer,
          fontSize: 12,
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w800,
        ),
        titleLarge: TextStyle(
          color: appTheme.black900,
          fontSize: 20,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
        titleMedium: TextStyle(
          color: appTheme.black900,
          fontSize: 18,
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w700,
        ),
        titleSmall: TextStyle(
          color: appTheme.red600,
          fontSize: 14,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
      );
}

class ColorSchemes {
  static final lightCodeColorScheme = ColorScheme.light(
    primary: Color(0X3F17CE92),
    primaryContainer: Color(0XFF2B27F2),
    secondaryContainer: Color(0XFFB0B4C3),
    errorContainer: Color(0XFF616161),
    onError: Color(0XFF8D9294),
    onErrorContainer: Color(0X1E0E0E0E),
    onPrimary: Color(0XFF141718),
    onPrimaryContainer: Color(0XFFFFFFFF),
    onSecondaryContainer: Color(0XFF212121),
  );
}

class LightCodeColors {
  Color get amber700 => Color(0XFFEAA010);

  Color get black900 => Color(0XFF000000);

  Color get blueGrey100 => Color(0XFFCCCCCC);

  Color get blueGrey10001 => Color(0XFFD9D9D9);

  Color get blueGrey10002 => Color(0XFFD6D6D6);

  Color get blueGrey400 => Color(0XFF888888);

  Color get grey200 => Color(0XFFE5E8EB);

  Color get grey300 => Color(0XFFE3E3E3);

  Color get grey400 => Color(0XFFB1B1B1);

  Color get grey50 => Color(0XFFFBFCFC);

  Color get grey5001 => Color(0XFFF9F9F9);

  Color get grey600 => Color(0XFF747171);

  Color get grey900 => Color(0XFF22262E);

  Color get grey9007f => Color(0X7F23262F);

  Color get indigo500 => Color(0XFF4267B2);

  Color get red600 => Color(0XFFD44638);

  Color get redA700 => Color(0XFFF90D0D);
}
