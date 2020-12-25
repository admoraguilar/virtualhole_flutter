import 'package:flutter/foundation.dart';
import '../virtualhole_api_client_dart.dart';

class APIResponse<T> {
  APIResponse({
    @required this.body,
    @required this.error,
  });

  T body;
  APIError error;
}
