import 'package:equatable/equatable.dart';
import 'package:virtualhole_flutter/api/contents/social.dart';

class Creator implements Equatable {
  static List<Creator> fromJsonDecode(dynamic jsonDecode) {
    if (jsonDecode == null) {
      return [];
    }
    return (jsonDecode as List).map((e) => Creator.fromJson(e)).toList();
  }

  const Creator({
    this.universalName,
    this.universalId,
    this.wikiUrl,
    this.avatarUrl,
    this.isHidden,
    this.affiliations,
    this.isGroup,
    this.depth,
    this.socials,
    this.customKeywords,
  });

  final String universalName;
  final String universalId;
  final String wikiUrl;
  final String avatarUrl;
  final bool isHidden;
  final List<String> affiliations;
  final bool isGroup;
  final int depth;
  final List<Social> socials;
  final List<String> customKeywords;

  factory Creator.fromJson(Map<String, dynamic> json) {
    return Creator(
      universalName: json['universalName'],
      universalId: json['universalId'],
      wikiUrl: json['wikiUrl'],
      avatarUrl: json['avatarUrl'],
      isHidden: json['isHidden'],
      affiliations: json['affiliations'],
      isGroup: json['isGroup'],
      depth: json['depth'],
      socials: Social.fromJsonDecode(json['socials']),
      customKeywords: json['customKeywords'],
    );
  }

  @override
  List<Object> get props => [
        universalName,
        universalId,
        wikiUrl,
        avatarUrl,
        isHidden,
        affiliations,
        isGroup,
        depth,
        socials,
        customKeywords,
      ];

  @override
  bool get stringify => true;
}
