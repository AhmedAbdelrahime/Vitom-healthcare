import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:complex_ui_rive_animation/core/utils/size_utils.dart';

String _appTheme = "primary";

/// Helper class for managing themes and colors.
class ThemeHelper {
  // A map of custom color themes supported by the app
  Map<String, PrimaryColors> _supportedCustomColor = {
    'primary': PrimaryColors()
  };

// A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'primary': ColorSchemes.primaryColorScheme
  };

  /// Changes the app theme to [_newTheme].
  void changeTheme(String _newTheme) {
    _appTheme = _newTheme;
  }

  /// Returns the primary colors for the current theme.
  PrimaryColors _getThemeColors() {
    //throw exception to notify given theme is not found or not generated by the generatorif (!_supportedCustomColor.containsKey(_appTheme)){  throw Exception(               "$_appTheme is not found.Make sure you have added this theme class in JSON Try running flutter pub run build_runner");      } //return theme from map
    return _supportedCustomColor[_appTheme] ?? PrimaryColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    //throw exception to notify given theme is not found or not generated by the generator if (!_supportedColorScheme.containsKey(_appTheme)){   throw Exception(                "$_appTheme is not found.Make sure you have added this theme class in JSON Try running flutter pub run build_runner");       }  //return theme from map
    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.primaryColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
    );
  }

  /// Returns the primary colors for the current theme.
  PrimaryColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

/// Class containing the supported text theme styles.
class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        labelMedium: TextStyle(
          color: appTheme.gray500,
          fontSize: 10,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
        ),
        titleMedium: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 16,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
      );
}

/// Class containing the supported color schemes.
class ColorSchemes {
  static final primaryColorScheme = ColorScheme.light(
    // Primary colors
    primary: Color(0XFFFFFFFF),

    // On colors(text colors)
    onPrimary: Color(0XFF38403F),
  );
}

/// Class containing custom colors for a primary theme.
class PrimaryColors {
  // Cyan
  Color get cyan100 => Color(0XFFBAEDE8);
  Color get cyan300 => Color(0XFF52D1C6);

  // Gray
  Color get gray500 => Color(0XFF8E9C9B);
  Color get gray5001 => Color(0XFFF6FDFC);

  // Teal
  Color get teal300 => Color(0XFF33C0B3);
  Color get teal50 => Color(0XFFDCF6F4);
}

PrimaryColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();
