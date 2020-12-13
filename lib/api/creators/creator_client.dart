import 'package:virtualhole_flutter/api/common/api_client.dart';
import '../creators/requests/creator_query.dart';
import 'creator.dart';

export 'creator.dart';

class CreatorsClient extends APIClient {
  CreatorsClient({String domain})
      : assert(domain.isNotEmpty),
        super(domain: domain);

  @override
  String get version => 'api/v1';

  @override
  String get path => 'creators';

  Future<List<Creator>> get(CreatorQuery request) async {
    String path = '?Search=${request.search}';
    return Creator.fromJsonDecode(await getAsync(createUri(path)));
  }
}
