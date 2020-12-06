import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';

class SupportInfo implements Equatable {
  static List<SupportInfo> fromJsonDecode(dynamic jsonDecode) {
    return (jsonDecode as List).map((e) => SupportInfo.fromJson(e)).toList();
  }

  const SupportInfo({
    @required this.url,
    @required this.imagePath,
    @required this.header,
    @required this.content,
  });

  final String url;
  final String imagePath;
  final String header;
  final String content;

  factory SupportInfo.fromJson(Map<String, dynamic> json) {
    return SupportInfo(
        url: json['url'],
        imagePath: json['imagePath'],
        header: json['header'],
        content: json['content']);
  }

  @override
  List<Object> get props => [url, imagePath, header, content];

  @override
  bool get stringify => true;
}
