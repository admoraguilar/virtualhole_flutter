import 'package:flutter/foundation.dart';

class APIError {
  APIError({
    @required this.statusCode,
    @required this.reasonPhrase,
  }) : assert(statusCode != null && statusCode >= 100);

  final int statusCode;
  final String reasonPhrase;
}
