import 'package:equatable/equatable.dart';
import 'package:virtualhole_flutter/api/contents/content.dart';

class ContentDTO implements Equatable {
  static List<ContentDTO> fromJsonDecode(dynamic jsonDecode) {
    if (jsonDecode == null) {
      return [];
    }
    return (jsonDecode as List).map((e) => ContentDTO.fromJson(e)).toList();
  }

  const ContentDTO({
    this.content,
    this.creatorSocialId,
    this.creatorSocialName,
    this.creatorAvatarUrl,
    this.creationDateDisplay,
    this.scheduleDateDisplay,
  });

  final Content content;
  final String creatorSocialId;
  final String creatorSocialName;
  final String creatorAvatarUrl;
  final String creationDateDisplay;
  final String scheduleDateDisplay;

  factory ContentDTO.fromJson(Map<String, dynamic> json) {
    return ContentDTO(
      content: Content.fromJson(json['content']),
      creatorSocialId: json['creatorSocialId'],
      creatorSocialName: json['creatorSocialName'],
      creatorAvatarUrl: json['creatorAvatarUrl'],
      creationDateDisplay: json['creationDateDisplay'],
      scheduleDateDisplay: json['scheduleDateDisplay'],
    );
  }

  @override
  List<Object> get props => [
        content,
        creatorSocialId,
        creatorSocialName,
        creatorAvatarUrl,
        creationDateDisplay,
        scheduleDateDisplay,
      ];

  @override
  bool get stringify => true;
}
