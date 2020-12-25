import 'package:equatable/equatable.dart';
import '../virtualhole_api_client_dart.dart';

class ContentDTO implements Equatable {
  static List<ContentDTO> fromJsonDecode(dynamic jsonDecode) {
    if (jsonDecode == null) {
      return [];
    }
    return (jsonDecode as List).map((e) => ContentDTO.fromJson(e)).toList();
  }

  const ContentDTO({
    this.content,
    this.isAvailable,
    this.creationDateDisplay,
    this.scheduleDateDisplay,
  });

  final Content content;
  final bool isAvailable;
  final String creationDateDisplay;
  final String scheduleDateDisplay;

  factory ContentDTO.fromJson(Map<String, dynamic> json) {
    return ContentDTO(
      content: Content.fromJson(json['content']),
      isAvailable: json['isAvailable'],
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
        isAvailable,
        creationDateDisplay,
        scheduleDateDisplay,
      ];

  @override
  bool get stringify => true;
}
