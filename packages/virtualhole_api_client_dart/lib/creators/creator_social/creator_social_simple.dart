import 'package:equatable/equatable.dart';

class CreatorSocialSimple extends Equatable {
  static List<CreatorSocialSimple> fromJsonDecode(dynamic jsonDecode) {
    if (jsonDecode == null) {
      return [];
    }
    return (jsonDecode as List)
        .map((e) => CreatorSocialSimple.fromJson((e)))
        .toList();
  }

  CreatorSocialSimple({
    this.id,
    this.name,
    this.url,
    this.avatarUrl,
  })  : assert(id != null),
        assert(name != null),
        assert(url != null),
        assert(avatarUrl != null);

  final String id;
  final String name;
  final String url;
  final String avatarUrl;

  factory CreatorSocialSimple.fromJson(Map<String, dynamic> json) {
    return CreatorSocialSimple(
      id: json['id'],
      name: json['name'],
      url: json['url'],
      avatarUrl: json['avatarUrl'],
    );
  }

  @override
  List<Object> get props => [
        id,
        name,
        url,
        avatarUrl,
      ];

  @override
  bool get stringify => true;
}
