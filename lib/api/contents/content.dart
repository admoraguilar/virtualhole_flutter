import 'package:equatable/equatable.dart';
import 'package:virtualhole_flutter/api/api.dart';

class Content implements Equatable {
  static List<Content> fromJsonDecode(dynamic jsonDecode) {
    if (jsonDecode == null) {
      return [];
    }
    return (jsonDecode as List).map((e) => Content.fromJson(e)).toList();
  }

  const Content({
    this.socialType,
    this.contentType,
    this.creator,
    this.id,
    this.title,
    this.url,
    this.creationDate,
    this.tags,
  });

  final String socialType;
  final String contentType;
  final CreatorSimple creator;
  final String id;
  final String title;
  final String url;
  final DateTime creationDate;
  final List<String> tags;

  factory Content.fromJson(Map<String, dynamic> json) {
    String socialTypeKey = 'socialType';
    String contentTypeKey = 'contentType';

    if (json[socialTypeKey] == 'youtube') {
      if (json[contentTypeKey] == 'video') {
        return YouTubeVideo.fromJson(json);
      } else if (json[contentTypeKey] == 'broadcast') {
        return YouTubeBroadcast.fromJson(json);
      }
    }

    throw UnimplementedError(
        '[Content] Unimplmented content type: ${json[socialTypeKey]} : ${json[contentTypeKey]}');
  }

  factory Content.fromJsonDirect(Map<String, dynamic> json) {
    return Content(
      socialType: json['socialType'],
      contentType: json['contentType'],
      creator: json['creator'],
      id: json['id'],
      title: json['title'],
      url: json['url'],
      creationDate: DateTime.parse(json['creationDate']),
      tags: List<String>.from(json['tags']),
    );
  }

  @override
  List<Object> get props => [
        socialType,
        contentType,
        creator,
        id,
        title,
        url,
        creationDate,
        tags,
      ];

  @override
  bool get stringify => true;
}
