import 'package:flutter/foundation.dart';
import '../virtualhole_api_client_dart.dart';

class ApiResponse<T> {
  ApiResponse({
    @required this.body,
    @required this.error,
  });

  T body;
  ApiError error;
}
