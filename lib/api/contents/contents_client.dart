import 'package:virtualhole_flutter/api/api.dart';

class ContentsClient extends APIClient {
  ContentsClient({String domain})
      : assert(domain.isNotEmpty),
        super(domain: domain);

  @override
  String get version => 'api/v1';

  @override
  String get rootPath => 'contents';

  Future<APIResponse<List<ContentDTO>>> getDiscover(
      ContentRequest request) async {
    return await getAsync(
      createUri(
        slug: 'discover',
        queryParameters: request.toQueryMap(),
      ),
      ContentDTO.fromJsonDecode,
    );
  }

  Future<APIResponse<List<ContentDTO>>> getCommunity(
      ContentRequest request) async {
    return await getAsync(
      createUri(
        slug: 'community',
        queryParameters: request.toQueryMap(),
      ),
      ContentDTO.fromJsonDecode,
    );
  }

  Future<APIResponse<List<ContentDTO>>> getLive(ContentRequest request) async {
    return await getAsync(
      createUri(
        slug: 'live',
        queryParameters: request.toQueryMap(),
      ),
      ContentDTO.fromJsonDecode,
    );
  }

  Future<APIResponse<List<ContentDTO>>> getSchedule(
      ContentRequest request) async {
    return await getAsync(
      createUri(
        slug: 'scheduled',
        queryParameters: request.toQueryMap(),
      ),
      ContentDTO.fromJsonDecode,
    );
  }
}
