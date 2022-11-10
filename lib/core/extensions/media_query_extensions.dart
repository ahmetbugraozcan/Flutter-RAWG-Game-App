import 'package:flutter/material.dart';

/// Extension for [BuildContext] to get [MediaQuery] data
extension MediaQueryExtension on BuildContext {
  /// Get MediaQuery Data
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Get MediaQuery Size
  Size get size => mediaQuery.size;

  /// Get MediaQuery Height
  double get height => mediaQuery.size.height;

  /// Get MediaQuery Width
  double get width => mediaQuery.size.width;

  /// Get MediaQuery height percentage
  double get heightPercentage => height / 100;

  /// Get MediaQuery width percentage
  double get widthPercentage => width / 100;

  /// Get MediaQuery height percentage with given value [0-100]
  double dynamicHeight(num percentage) => heightPercentage * percentage;

  /// Get MediaQuery width percentage with given value [0-100]
  double dynamicWidth(num percentage) => widthPercentage * percentage;

  /// Get half the height
  double get halfTheHeight => dynamicHeight(50);

  /// Get half the width
  double get halfTheWidth => dynamicWidth(50);

  /// Get a quarter of the height
  double get quarterTheHeight => dynamicHeight(25);

  /// Get a quarter of the width
  double get quarterTheWidth => dynamicWidth(25);

  /// dynamic values with [dynamicHeight]
  double get extraLowValue => dynamicHeight(1);
  double get lowValue => dynamicHeight(2);
  double get mediumValue => dynamicHeight(4);
  double get highValue => dynamicHeight(8);
  double get extraHighValue => dynamicHeight(16);

  /// Is the device a small device?

}
