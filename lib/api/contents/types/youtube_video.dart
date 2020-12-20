import 'package:virtualhole_flutter/midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_flutter/api/api.dart';

class YouTubeVideo extends Content {
  static List<YouTubeVideo> fromJsonDecode(dynamic jsonDecode) {
    if (jsonDecode == null) {
      return [];
    }
    return (jsonDecode as List).map((e) => YouTubeVideo.fromJson(e)).toList();
  }

  const YouTubeVideo({
    String socialType,
    String contentType,
    String creatorId,
    String id,
    String title,
    String url,
    DateTime creationDate,
    List<String> tags,
    this.thumbnailUrl,
    this.description,
    this.duration,
    this.viewsCount,
    this.likesCount,
    this.dislikesCount,
  }) : super(
          socialType: socialType,
          contentType: contentType,
          creatorId: creatorId,
          id: id,
          title: title,
          url: url,
          creationDate: creationDate,
          tags: tags,
        );

  final String thumbnailUrl;
  final String description;
  final Duration duration;
  final int viewsCount;
  final int likesCount;
  final int dislikesCount;

  factory YouTubeVideo.fromJson(Map<String, dynamic> json) {
    Content content = Content.fromJsonDirect(json);

    return YouTubeVideo(
      socialType: content.socialType,
      contentType: content.contentType,
      creatorId: content.creatorId,
      id: content.id,
      title: content.title,
      url: content.url,
      creationDate: content.creationDate,
      tags: content.tags,
      thumbnailUrl: json['thumbnailUrl'],
      description: json['description'],
      duration: DurationExtensions.parse(json['duration']),
      viewsCount: json['viewsCount'],
      likesCount: json['likesCount'],
      dislikesCount: json['dislikesCount'],
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
        thumbnailUrl,
        description,
        duration,
        viewsCount,
        likesCount,
        dislikesCount,
      ];

  @override
  bool get stringify => true;
}
