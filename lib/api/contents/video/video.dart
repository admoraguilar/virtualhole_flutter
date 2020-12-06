import 'package:virtualhole_flutter/api/contents/content.dart';
import 'package:virtualhole_flutter/api/contents/platform.dart';

class Video extends Content {
  static List<Video> fromJsonDecode(dynamic jsonDecode) {
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
    return Video(
      title: json['title'],
      platform: json['platform'],
      id: json['id'],
      url: json['url'],
      creator: json['creator'],
      creatorId: json['creatorId'],
      creatorUniversal: json['creatorUniversal'],
      creatorIdUniversal: json['creatorIdUniversal'],
      creationDate: json['creationDate'],
      creationDateDisplay: json['creationDateDisplay'],
      tags: json['tags'],
      thumbnailUrl: json['thumbnailUrl'],
      description: json['description'],
      duration: json['duration'],
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
