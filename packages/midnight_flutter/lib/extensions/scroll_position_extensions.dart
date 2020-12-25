import 'package:flutter/material.dart';

extension ScrollPositionExtensions on ScrollPosition {
  double get normalizedScrollExtent {
    double range = maxScrollExtent - minScrollExtent;
    double current = pixels - minScrollExtent;
    return current / range;
  }
}
