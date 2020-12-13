import 'package:virtualhole_flutter/api/common/api_client.dart';
import 'support_info.dart';

export 'support_info.dart';

class ResourcesClient extends APIClient {
  ResourcesClient({String domain})
      : assert(domain.isNotEmpty),
        super(domain: domain);

  @override
  String get version => "api/v1";

  @override
  String get rootPath => "resources";

  Future<List<SupportInfo>> getSupportListAsync() async {
    String query = '?path=dynamic/support-list.json';
    return SupportInfo.fromJsonDecode(await getAsync(createUri(query)));
  }

  String buildObjectUrl(String path) {
    String query = '?path=$path';
    return createUri(query);
  }
}
