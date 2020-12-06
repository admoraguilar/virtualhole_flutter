import 'package:equatable/equatable.dart';
import 'platform.dart';

class Social implements Equatable {
  static List<Social> fromJsonDecode(dynamic jsonDecode) {
    if (jsonDecode == null) {
      return [];
    }
    return (jsonDecode as List).map((e) => Social.fromJson(e)).toList();
  }

  const Social({
    this.name,
    this.platform,
    this.id,
    this.url,
    this.avatarUrl,
    this.customKeywords,
  });

  final String name;
  final Platform platform;
  final String id;
  final String url;
  final String avatarUrl;
  final List<String> customKeywords;

  factory Social.fromJson(Map<String, dynamic> json) {
    return Social(
        name: json['name'],
        platform: Platform.values[json['platform']],
        id: json['id'],
        url: json['url'],
        avatarUrl: json['avatarUrl'],
        customKeywords: List<String>.from(json['customKeywords']));
  }

  @override
  List<Object> get props =>
      [name, platform, id, url, avatarUrl, customKeywords];

  @override
  bool get stringify => true;
}
