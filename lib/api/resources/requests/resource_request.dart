import 'package:virtualhole_flutter/api/common/api_request.dart';

class ResourceRequest extends APIRequest {
  const ResourceRequest({
    DateTime timestamp,
    String locale,
    this.path,
  }) : super(
          timestamp: timestamp,
          locale: locale,
        );

  final String path;

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> superMap = super.toJson();
    superMap.addAll({
      'path': path,
    });
    return superMap;
  }
}
