import 'package:virtualhole_flutter/api/api.dart';

class YouTubeBroadcast extends YouTubeVideo {
  static List<YouTubeBroadcast> fromJsonDecode(dynamic jsonDecode) {
    if (jsonDecode == null) {
      return [];
    }
    return (jsonDecode as List)
        .map((e) => YouTubeBroadcast.fromJson(e))
        .toList();
  }

  const YouTubeBroadcast({
    String socialType,
    String contentType,
    CreatorSimple creator,
    String id,
    String title,
    String url,
    DateTime creationDate,
    List<String> tags,
    String thumbnailUrl,
    String description,
    Duration duration,
    int viewsCount,
    int likesCount,
    int dislikesCount,
    this.isLive,
    this.viewerCount,
    this.scheduleDate,
  }) : super(
          socialType: socialType,
          contentType: contentType,
          creator: creator,
          id: id,
          title: title,
          url: url,
          creationDate: creationDate,
          tags: tags,
          thumbnailUrl: thumbnailUrl,
          description: description,
          duration: duration,
          viewsCount: viewsCount,
          likesCount: likesCount,
          dislikesCount: dislikesCount,
        );

  final bool isLive;
  final int viewerCount;
  final DateTime scheduleDate;

  factory YouTubeBroadcast.fromJson(Map<String, dynamic> json) {
    YouTubeVideo youtubeVideo = YouTubeVideo.fromJson(json);

    return YouTubeBroadcast(
      socialType: youtubeVideo.socialType,
      contentType: youtubeVideo.contentType,
      creator: youtubeVideo.creator,
      id: youtubeVideo.id,
      title: youtubeVideo.title,
      url: youtubeVideo.url,
      creationDate: youtubeVideo.creationDate,
      tags: youtubeVideo.tags,
      thumbnailUrl: youtubeVideo.thumbnailUrl,
      description: youtubeVideo.description,
      duration: youtubeVideo.duration,
      viewsCount: youtubeVideo.viewsCount,
      likesCount: youtubeVideo.likesCount,
      dislikesCount: youtubeVideo.dislikesCount,
      isLive: json['isLive'],
      viewerCount: json['viewerCount'],
      scheduleDate: json['scheduleDate'],
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
        thumbnailUrl,
        description,
        duration,
        viewsCount,
        likesCount,
        dislikesCount,
        isLive,
        viewerCount,
        scheduleDate,
      ];

  @override
  bool get stringify => true;
}
