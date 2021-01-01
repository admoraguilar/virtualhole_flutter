import '../virtualhole_api_client_dart.dart';

class ContentsClient extends ApiClient {
  ContentsClient({String domain})
      : assert(domain.isNotEmpty),
        super(domain);

  @override
  String get version => 'api/v1';

  @override
  String get rootPath => 'contents';

  Future<ApiResponse<List<ContentDTO>>> getDiscover(
      ContentRequest request) async {
    return await getRequest(
      createUri(
        slug: 'discover',
        queryParameters: request.toQueryMap(),
      ),
      ContentDTO.fromJsonDecode,
    );
  }

  Future<ApiResponse<List<ContentDTO>>> getCommunity(
      ContentRequest request) async {
    return await getRequest(
      createUri(
        slug: 'community',
        queryParameters: request.toQueryMap(),
      ),
      ContentDTO.fromJsonDecode,
    );
  }

  Future<ApiResponse<List<ContentDTO>>> getLive(ContentRequest request) async {
    return await getRequest(
      createUri(
        slug: 'live',
        queryParameters: request.toQueryMap(),
      ),
      ContentDTO.fromJsonDecode,
    );
  }

  Future<ApiResponse<List<ContentDTO>>> getSchedule(
      ContentRequest request) async {
    return await getRequest(
      createUri(
        slug: 'scheduled',
        queryParameters: request.toQueryMap(),
      ),
      ContentDTO.fromJsonDecode,
    );
  }
}
