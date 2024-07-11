import 'package:flutter/material.dart';
import 'package:complex_ui_rive_animation/core/theme/theme_helper.dart';
import 'package:complex_ui_rive_animation/core/utils/size_utils.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillTeal => BoxDecoration(
        color: appTheme.teal300,
      );

  // White decorations
  static BoxDecoration get white => BoxDecoration(
        color: theme.colorScheme.primary,
      );
}

class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder40 => BorderRadius.circular(
        40,
      );
  static BorderRadius get circleBorder8 => BorderRadius.circular(
        8,
      );

  // Custom borders
  static BorderRadius get customBorderTL30 => BorderRadius.vertical(
        top: Radius.circular(30),
      );
}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
