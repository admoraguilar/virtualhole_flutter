import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:virtualhole_flutter/api/api.dart';

abstract class APIClient {
  APIClient({this.domain}) : assert(domain.isNotEmpty);

  final String domain;

  String get version;
  String get rootPath;

  Future<APIResponse<T>> getAsync<T>(
      Uri uri, T Function(dynamic) decoder) async {
    http.Response res = await http.get(uri);
    return APIResponse(
      body: decoder(res.body),
      error: _createError(res),
    );
  }

  Future<APIResponse<String>> postAsync(dynamic uri, dynamic body) async {
    http.Response res = await http.post(
      uri,
      headers: <String, String>{'Content-Type': 'application/json'},
      body: body,
    );
    return APIResponse(
      body: res.body,
      error: _createError(res),
    );
  }

  Uri createUri({
    String subPath,
    String slug,
    Map<String, dynamic> queryParameters,
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

    if (slug != null && subPath.isNotEmpty) {
      path += '/$slug';
    }

    return Uri.https(domain, path, queryParameters);
  }

  APIError _createError(http.Response res) {
    return res.statusCode >= 400
        ? APIError(
            statusCode: res.statusCode,
            reasonPhrase: res.reasonPhrase,
          )
        : null;
  }
}
