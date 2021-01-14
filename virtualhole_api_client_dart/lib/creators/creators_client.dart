import '../virtualhole_api_client_dart.dart';

class CreatorsClient extends ApiClient {
  CreatorsClient({String domain})
      : assert(domain.isNotEmpty),
        super(domain);

  @override
  String get version => 'api/v1';

  @override
  String get rootPath => 'creators';

  Future<ApiResponse<List<Creator>>> get(CreatorRequest request) async {
    return await getRequest(createUri(queryParameters: request.toQueryMap()),
        Creator.fromJsonDecode);
  }
}
