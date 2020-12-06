import 'package:virtualhole_flutter/api/contents/platform.dart';
import 'package:virtualhole_flutter/api/contents/video/video.dart';

class Broadcast extends Video {
  static List<Broadcast> fromJsonDecode(dynamic jsonDecode) {
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
    return Broadcast(
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
