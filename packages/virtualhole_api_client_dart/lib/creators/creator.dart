import 'package:equatable/equatable.dart';
import '../virtualhole_api_client_dart.dart';

class Creator implements Equatable {
  static List<Creator> fromJsonDecode(dynamic jsonDecode) {
    if (jsonDecode == null) {
      return [];
    }
    return (jsonDecode as List).map((e) => Creator.fromJson(e)).toList();
  }

  const Creator({
    this.name,
    this.id,
    this.avatarUrl,
    this.isHidden,
    this.affiliations,
    this.isGroup,
    this.depth,
    this.socials,
  });

  final String id;
  final String name;
  final String avatarUrl;
  final bool isHidden;
  final bool isGroup;
  final int depth;
  final List<String> affiliations;
  final List<CreatorSocial> socials;

  factory Creator.fromJson(Map<String, dynamic> json) {
    return Creator(
      name: json['name'],
      id: json['id'],
      avatarUrl: json['avatarUrl'],
      isHidden: json['isHidden'],
      affiliations: List<String>.from(json['affiliations']),
      isGroup: json['isGroup'],
      depth: json['depth'],
      socials: CreatorSocial.fromJsonDecode(json['socials']),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'avatarUrl': avatarUrl,
        'isHidden': isHidden,
        'affiliations': affiliations,
        'isGroup': isGroup,
        'depth': depth,
        'socials': socials.map((s) => s.toJson()).toList(),
      };

  @override
  List<Object> get props => [
        name,
        id,
        avatarUrl,
        isHidden,
        affiliations,
        isGroup,
        depth,
        socials,
      ];

  @override
  bool get stringify => true;
}
