import 'package:flutter/foundation.dart';
import 'package:virtualhole_flutter/api/api.dart';

class APIResponse<T> {
  APIResponse({
    @required this.body,
    @required this.error,
  });

  T body;
  APIError error;
}
