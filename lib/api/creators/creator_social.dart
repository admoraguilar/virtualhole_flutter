import 'package:equatable/equatable.dart';

class CreatorSocial implements Equatable {
  static List<CreatorSocial> fromJsonDecode(dynamic jsonDecode) {
    if (jsonDecode == null) {
      return [];
    }
    return (jsonDecode as List).map((e) => CreatorSocial.fromJson(e)).toList();
  }

  const CreatorSocial({
    this.socialType,
    this.name,
    this.id,
    this.url,
    this.avatarUrl,
  });

  final String socialType;
  final String name;
  final String id;
  final String url;
  final String avatarUrl;

  factory CreatorSocial.fromJson(Map<String, dynamic> json) {
    return CreatorSocial(
      socialType: json['socialType'],
      name: json['name'],
      id: json['id'],
      url: json['url'],
      avatarUrl: json['avatarUrl'],
    );
  }

  @override
  List<Object> get props => [
        socialType,
        name,
        id,
        url,
        avatarUrl,
      ];

  @override
  bool get stringify => true;
}
