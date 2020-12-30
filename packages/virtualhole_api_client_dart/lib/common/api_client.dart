import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../virtualhole_api_client_dart.dart';

abstract class ApiClient {
  ApiClient({this.domain}) : assert(domain.isNotEmpty);

  final String domain;

  String get version;
  String get rootPath;

  Future<ApiResponse<T>> getAsync<T>(
      Uri uri, T Function(dynamic) decoder) async {
    print('[API Client] Sending GET: ${uri.toString()}');
    http.Response res = await http.get(uri).timeout(Duration(seconds: 30));
    return ApiResponse(
      body: decoder(jsonDecode(res.body)),
      error: _createError(res),
    );
  }

  Future<ApiResponse<String>> postAsync(dynamic uri, dynamic body) async {
    print('[API Client] Sending POST: ${uri.toString()}');
    http.Response res = await http
        .post(
          uri,
          headers: <String, String>{'Content-Type': 'application/json'},
          body: body,
        )
        .timeout(Duration(seconds: 30));
    return ApiResponse(
      body: res.body,
      error: _createError(res),
    );
  }

  Uri createUri({
    String subPath,
    String slug,
    Map<String, String> queryParameters,
  }) {
    String path = '';

    if (version.isNotEmpty) {
      path += '/$version';
    }

    if (rootPath.isNotEmpty) {
      path += '/$rootPath';
    }

    if (subPath != null && subPath.isNotEmpty) {
      path += '/$subPath';
    }

    if (slug != null && slug.isNotEmpty) {
      path += '/$slug';
    }

    return Uri.https(domain, path, queryParameters);
  }

  ApiError _createError(http.Response res) {
    return res.statusCode >= 400
        ? ApiError(
            statusCode: res.statusCode,
            reasonPhrase: res.reasonPhrase,
          )
        : null;
  }
}
