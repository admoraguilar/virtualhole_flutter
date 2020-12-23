import 'package:virtualhole_flutter/api/api.dart';

class ResourcesClient extends APIClient {
  ResourcesClient({String domain})
      : assert(domain.isNotEmpty),
        super(domain: domain);

  @override
  String get version => "api/v1";

  @override
  String get rootPath => "resources";

  Future<APIResponse<List<SupportInfo>>> getSupportListAsync() async {
    return await getAsync(
      buildObjectUri('dynamic/support-list.json'),
      SupportInfo.fromJsonDecode,
    );
  }

  Uri buildObjectUri(String path) {
    return createUri(queryParameters: {'path': path});
  }
}
