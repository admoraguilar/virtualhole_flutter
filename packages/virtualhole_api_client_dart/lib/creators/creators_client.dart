import '../virtualhole_api_client_dart.dart';

class CreatorsClient extends APIClient {
  CreatorsClient({String domain})
      : assert(domain.isNotEmpty),
        super(domain: domain);

  @override
  String get version => 'api/v1';

  @override
  String get rootPath => 'creators';

  Future<APIResponse<List<Creator>>> get(CreatorRequest request) async {
    return await getAsync(createUri(queryParameters: request.toQueryMap()),
        Creator.fromJsonDecode);
  }
}