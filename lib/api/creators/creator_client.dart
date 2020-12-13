import 'package:virtualhole_flutter/api/common/api_client.dart';
import 'requests/creator_request.dart';
import 'creator.dart';

export 'creator.dart';

class CreatorsClient extends APIClient {
  CreatorsClient({String domain})
      : assert(domain.isNotEmpty),
        super(domain: domain);

  @override
  String get version => 'api/v1';

  @override
  String get rootPath => 'creators';

  Future<List<Creator>> get(CreatorRequest request) async {
    String path = '?Search=${request.search}';
    return Creator.fromJsonDecode(await getAsync(createUri(path)));
  }
}
