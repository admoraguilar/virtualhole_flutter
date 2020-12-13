import 'package:equatable/equatable.dart';
import 'package:virtualhole_flutter/api/contents/types/youtube_broadcast.dart';
import 'package:virtualhole_flutter/api/contents/types/youtube_video.dart';

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
    this.creatorId,
    this.id,
    this.title,
    this.url,
    this.creationDate,
    this.tags,
  });

  final String socialType;
  final String contentType;
  final String creatorId;
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

    return Content(
      socialType: json['socialType'],
      contentType: json['contentType'],
      creatorId: json['creatorId'],
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
        creatorId,
        id,
        title,
        url,
        creationDate,
        tags,
      ];

  @override
  bool get stringify => true;
}
