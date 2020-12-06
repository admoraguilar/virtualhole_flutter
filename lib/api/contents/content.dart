import 'package:equatable/equatable.dart';
import 'platform.dart';

class Content implements Equatable {
  static List<Content> fromJsonDecode(dynamic jsonDecode) {
    if (jsonDecode == null) {
      return [];
    }
    return (jsonDecode as List).map((e) => Content.fromJson(e)).toList();
  }

  const Content({
    this.title,
    this.platform,
    this.id,
    this.url,
    this.creator,
    this.creatorId,
    this.creatorUniversal,
    this.creatorIdUniversal,
    this.creationDate,
    this.creationDateDisplay,
    this.tags,
  });

  final String title;
  final Platform platform;
  final String id;
  final String url;
  final String creator;
  final String creatorId;
  final String creatorUniversal;
  final String creatorIdUniversal;
  final DateTime creationDate;
  final String creationDateDisplay;
  final List<String> tags;

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      title: json['title'],
      platform: Platform.values[json['platform']],
      id: json['id'],
      url: json['url'],
      creator: json['creator'],
      creatorId: json['creatorId'],
      creatorUniversal: json['creatorUniversal'],
      creatorIdUniversal: json['creatorIdUniversal'],
      creationDate: DateTime.parse(json['creationDate']),
      creationDateDisplay: json['creationDateDisplay'],
      tags: List<String>.from(json['tags']),
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
      ];

  @override
  bool get stringify => true;
}
