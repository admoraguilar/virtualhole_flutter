import 'package:virtualhole_flutter/api/api.dart';

class ContentsClient extends APIClient {
  ContentsClient({String domain})
      : assert(domain.isNotEmpty),
        super(domain: domain);

  @override
  String get version => 'api/v1';

  @override
  String get rootPath => 'contents';

  Future<APIResponse<List<ContentDTO>>> get(ContentRequest request) async {
    return await getAsync(createUri(queryParameters: request.toJson()),
        ContentDTO.fromJsonDecode);
  }
}
