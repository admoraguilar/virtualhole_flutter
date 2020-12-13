import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class APIClient {
  APIClient({this.domain}) : assert(domain.isNotEmpty);

  final String domain;

  String get version;
  String get rootPath;

  Future<dynamic> getAsync<T>(String url) async {
    http.Response res = await http.get(url);
    return json.decode(res.body);
  }

  Future<dynamic> postAsync(String url, dynamic body) async {
    http.Response res = await http.post(url,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: body);
    return json.decode(res.body);
  }

  String createUri(String slug, {String subPath}) {
    String fullPath = '$domain';

    if (version.isNotEmpty) {
      fullPath += '/$version';
    }

    if (rootPath.isNotEmpty) {
      fullPath += '/$rootPath';
    }

    if (subPath != null && subPath.isNotEmpty) {
      fullPath += '/$subPath';
    }

    fullPath += '/$slug';
    return fullPath;
  }
}
