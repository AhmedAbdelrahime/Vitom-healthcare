import 'package:flutter/material.dart';
import 'package:complex_ui_rive_animation/core/theme/theme_helper.dart';
import 'package:complex_ui_rive_animation/core/utils/size_utils.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Label text style
  static get labelMediumCyan100 => theme.textTheme.labelMedium!.copyWith(
        color: appTheme.cyan100,
        fontWeight: FontWeight.w600,
      );
  // Title text style
  static get titleMediumPrimary => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 18,
      );
  static get titleMediumPrimary_1 => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primary,
      );
}

extension on TextStyle {}
