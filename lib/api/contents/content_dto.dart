import 'package:equatable/equatable.dart';
import 'package:virtualhole_flutter/api/api.dart';

class ContentDTO implements Equatable {
  static List<ContentDTO> fromJsonDecode(dynamic jsonDecode) {
    if (jsonDecode == null) {
      return [];
    }
    return (jsonDecode as List).map((e) => ContentDTO.fromJson(e)).toList();
  }

  const ContentDTO({
    this.content,
    this.creationDateDisplay,
    this.scheduleDateDisplay,
  });

  final Content content;
  final String creationDateDisplay;
  final String scheduleDateDisplay;

  factory ContentDTO.fromJson(Map<String, dynamic> json) {
    return ContentDTO(
      content: Content.fromJson(json['content']),
      creationDateDisplay: json.containsKey('creationDateDisplay')
          ? json['creationDateDisplay']
          : '',
      scheduleDateDisplay: json.containsKey('scheduleDateDisplay')
          ? json['scheduleDateDisplay']
          : '',
    );
  }

  @override
  List<Object> get props => [
        content,
        creationDateDisplay,
        scheduleDateDisplay,
      ];

  @override
  bool get stringify => true;
}
