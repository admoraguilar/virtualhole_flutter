import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';

class MLog {
  static void log(
    String message, {
    String prepend,
    bool isSupressed = true,
  }) {
    if (!kDebugMode && !isSupressed) {
      return;
    }

    if (prepend != null && prepend.isNotEmpty) {
      debugPrint('[${DateTime.now()}] [$prepend] $message');
    } else {
      debugPrint('[${DateTime.now()}] $message');
    }
  }
}
