import 'package:virtualhole_api_client_dart/common/api_error.dart';
import '../common/api_response.dart';

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
        throw Exception(
            '[${(ApiResponseProvider)}] ${response.error.statusCode} - ${response.error.reasonPhrase}');
      }
    }

    return response.body;
  }
}
