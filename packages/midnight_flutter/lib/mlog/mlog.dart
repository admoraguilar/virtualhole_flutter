import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MLog {
  static Exception exception(
    Exception Function(String message) exceptionBuilder,
    Object message, {
    Object prepend,
  }) {
    assert(exception != null);
    assert(message != null);

    if (prepend != null) {
      return exceptionBuilder(
          '[${DateTime.now()}] [${prepend.toString()}] ${message.toString()}');
    } else {
      return exceptionBuilder('[${DateTime.now()}] ${message.toString()}');
    }
  }

  static void log(
    Object message, {
    Object prepend,
    bool isSupressed = true,
  }) {
    assert(message != null);

    if (!kDebugMode && !isSupressed) {
      return;
    }

    if (prepend != null) {
      debugPrint(
          '[${DateTime.now()}] [${prepend.toString()}] ${message.toString()}');
    } else {
      debugPrint('[${DateTime.now()}] ${message.toString()}');
    }
  }
}
