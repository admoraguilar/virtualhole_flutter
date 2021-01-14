import 'package:equatable/equatable.dart';
import '../virtualhole_api_client_dart.dart';

class CreatorSimple extends Equatable {
  CreatorSimple({
    this.id,
    this.name,
    this.avatarUrl,
    this.affiliations,
    this.social,
  })  : assert(id != null),
        assert(name != null),
        assert(avatarUrl != null),
        assert(affiliations != null),
        assert(social != null);

  final String id;
  final String name;
  final String avatarUrl;
  final List<String> affiliations;
  final CreatorSocialSimple social;

  factory CreatorSimple.fromJson(Map<String, dynamic> json) {
    return CreatorSimple(
      id: json['id'],
      name: json['name'],
      avatarUrl: json['avatarUrl'],
      affiliations: List<String>.from(json['affiliations']),
      social: CreatorSocialSimple.fromJson(json['social']),
    );
  }

  @override
  List<Object> get props => [
        id,
        name,
        avatarUrl,
        affiliations,
        social,
      ];

  @override
  bool get stringify => true;
}
