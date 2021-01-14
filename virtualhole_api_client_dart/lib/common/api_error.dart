import 'package:flutter/foundation.dart';

class ApiError {
  ApiError({
    @required this.statusCode,
    @required this.reasonPhrase,
  }) : assert(statusCode != null && statusCode >= 100);

  final int statusCode;
  final String reasonPhrase;
}
