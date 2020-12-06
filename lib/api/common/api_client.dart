import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class APIClient {
  APIClient({this.domain});

  final String domain;

  String get version;
  String get path;

  Future<dynamic> postAsync(String url, dynamic body) async {
    http.Response res = await http.post(url,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: body);
    return json.decode(res.body);
  }

  Future<dynamic> getAsync<T>(String url) async {
    http.Response res = await http.get(url);
    return json.decode(res.body);
  }

  String createUri(String slug, {String overridePath}) {
    String fullPath = '$domain';

    if (version.isNotEmpty) {
      fullPath += '/$version';
    }

    if (path.isNotEmpty) {
      fullPath += '/$path';
    }

    if (overridePath != null && overridePath.isNotEmpty) {
      fullPath += '/$overridePath';
    }

    fullPath += '/$slug';
    return fullPath;
  }
}
