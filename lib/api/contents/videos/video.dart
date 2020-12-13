import 'package:virtualhole_flutter/api/contents/content.dart';
import 'package:virtualhole_flutter/api/contents/platform.dart';
import 'package:virtualhole_flutter/common/duration_extensions.dart';

class Video extends Content {
  static List<Video> fromJsonDecode(dynamic jsonDecode) {
    if (jsonDecode == null) {
      return [];
    }
    return (jsonDecode as List).map((e) => Video.fromJson(e)).toList();
  }

  const Video({
    String title,
    Platform platform,
    String id,
    String url,
    String creator,
    String creatorId,
    String creatorUniversal,
    String creatorIdUniversal,
    DateTime creationDate,
    String creationDateDisplay,
    List<String> tags,
    this.thumbnailUrl,
    this.description,
    this.duration,
    this.viewCount,
  }) : super(
          title: title,
          platform: platform,
          id: id,
          url: url,
          creator: creator,
          creatorId: creatorId,
          creatorUniversal: creatorUniversal,
          creatorIdUniversal: creatorIdUniversal,
          creationDate: creationDate,
          creationDateDisplay: creationDateDisplay,
          tags: tags,
        );

  final String thumbnailUrl;
  final String description;
  final Duration duration;
  final int viewCount;

  factory Video.fromJson(Map<String, dynamic> json) {
    Content content = Content.fromJson(json);

    return Video(
      title: content.title,
      platform: content.platform,
      id: content.id,
      url: content.url,
      creator: content.creator,
      creatorId: content.creatorId,
      creatorUniversal: content.creatorUniversal,
      creatorIdUniversal: content.creatorIdUniversal,
      creationDate: content.creationDate,
      creationDateDisplay: content.creationDateDisplay,
      tags: content.tags,
      thumbnailUrl: json['thumbnailUrl'],
      description: json['description'],
      duration: DurationExtensions.parse(json['duration']),
      viewCount: json['viewCount'],
    );
  }

  @override
  List<Object> get props => [
        title,
        platform,
        id,
        url,
        creator,
        creatorId,
        creatorUniversal,
        creatorIdUniversal,
        creationDate,
        creationDateDisplay,
        tags,
        thumbnailUrl,
        description,
        duration,
        viewCount,
      ];

  @override
  bool get stringify => true;
}
