import 'package:virtualhole_api_client_dart/common/api_error.dart';
import '../common/api_response.dart';

class APIResponseProvider<T> {
  APIResponseProvider(
    this.future, {
    this.onError,
  }) : assert(future != null);

  final Future<APIResponse<T>> future;
  final Function(APIError error) onError;

  Future<T> getResult() async {
    APIResponse<T> response = await future;

    if (response.error != null) {
      if (onError != null) {
        onError(response.error);
      } else {
        throw Exception(
            '[${(APIResponseProvider).toString()}] ${response.error.statusCode} - ${response.error.reasonPhrase}');
      }
    }

    return response.body;
  }
}
