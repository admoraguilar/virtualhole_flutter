import '../virtualhole_api_client_dart.dart';

class ResourcesClient extends ApiClient {
  ResourcesClient({String domain})
      : assert(domain.isNotEmpty),
        super(domain: domain);

  @override
  String get version => "api/v1";

  @override
  String get rootPath => "resources";

  Future<ApiResponse<List<SupportInfo>>> getSupportListAsync() async {
    return await getAsync(
      buildObjectUri('dynamic/support-list.json'),
      SupportInfo.fromJsonDecode,
    );
  }

  Uri buildObjectUri(String path) {
    return createUri(queryParameters: {'path': path});
  }
}
