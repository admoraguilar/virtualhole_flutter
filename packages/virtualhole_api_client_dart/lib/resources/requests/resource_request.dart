import '../../virtualhole_api_client_dart.dart';

class ResourceRequest extends APIRequest {
  const ResourceRequest({
    DateTime timestamp,
    String locale,
    this.path,
  }) : super(
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

  ResourceRequest copyWith({
    DateTime timestamp,
    String locale,
    String path,
  }) {
    return ResourceRequest(
      timestamp: timestamp ?? this.timestamp,
      locale: locale ?? this.locale,
      path: path ?? this.path,
    );
  }
}
