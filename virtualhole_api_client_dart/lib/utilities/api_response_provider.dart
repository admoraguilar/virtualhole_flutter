import 'package:midnight_flutter/midnight_flutter.dart';
import '../virtualhole_api_client_dart.dart';

class ApiResponseProvider<T> {
  ApiResponseProvider(
    this.future, {
    this.onError,
  }) : assert(future != null);

  final Future<ApiResponse<T>> future;
  final Function(ApiError error) onError;

  Future<T> getResult() async {
    ApiResponse<T> response = await future;

    if (response.error != null) {
      if (onError != null) {
        onError(response.error);
      } else {
        throw MLog.exception(
          (String message) => Exception(message),
          '${response.error.statusCode} - ${response.error.reasonPhrase}',
          prepend: runtimeType,
        );
      }
    }

    return response.body;
  }
}
