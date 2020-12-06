import 'package:virtualhole_flutter/api/contents/platform.dart';
import 'package:virtualhole_flutter/api/contents/video/video.dart';

class Broadcast extends Video {
  static List<Broadcast> fromJsonDecode(dynamic jsonDecode) {
    if (jsonDecode == null) {
      return [];
    }
    return (jsonDecode as List).map((e) => Broadcast.fromJson(e)).toList();
  }

  const Broadcast(
      {String title,
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
      String thumbnailUrl,
      String description,
      Duration duration,
      int viewCount,
      this.isLive,
      this.viewerCount,
      this.scheduleDate,
      this.scheduleDateDisplay})
      : super(
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
          thumbnailUrl: thumbnailUrl,
          description: description,
          duration: duration,
          viewCount: viewCount,
        );

  final bool isLive;
  final int viewerCount;
  final DateTime scheduleDate;
  final String scheduleDateDisplay;

  factory Broadcast.fromJson(Map<String, dynamic> json) {
    Video video = Video.fromJson(json);
    return Broadcast(
      title: video.title,
      platform: video.platform,
      id: video.id,
      url: video.url,
      creator: video.creator,
      creatorId: video.creatorId,
      creatorUniversal: video.creatorUniversal,
      creatorIdUniversal: video.creatorIdUniversal,
      creationDate: video.creationDate,
      creationDateDisplay: video.creationDateDisplay,
      tags: video.tags,
      thumbnailUrl: video.thumbnailUrl,
      description: video.description,
      duration: video.duration,
      viewCount: video.viewCount,
      isLive: json['isLive'],
      viewerCount: json['viewerCount'],
      scheduleDate: json['scheduleDate'],
      scheduleDateDisplay: json['scheduleDateDisplay'],
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
        isLive,
        viewerCount,
        scheduleDate,
        scheduleDateDisplay,
      ];

  @override
  bool get stringify => true;
}
