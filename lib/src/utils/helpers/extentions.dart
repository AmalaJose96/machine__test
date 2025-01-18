import 'package:flutter/material.dart';

extension SizedBoxExtension on num {
  /// Creates a SizedBox with a height equal to the number
  SizedBox get height => SizedBox(height: toDouble());

  /// Creates a SizedBox with a width equal to the number
  SizedBox get width => SizedBox(width: toDouble());
}
