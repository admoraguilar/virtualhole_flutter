import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';

class MLog {
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
