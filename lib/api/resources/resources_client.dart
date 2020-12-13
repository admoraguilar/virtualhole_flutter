import 'package:virtualhole_flutter/api/common/api_client.dart';
import 'package:virtualhole_flutter/api/resources/requests/resource_request.dart';
import 'support_info.dart';

export 'support_info.dart';

class ResourcesClient extends APIClient {
  ResourcesClient({String domain})
      : assert(domain.isNotEmpty),
        super(domain: domain);

  @override
  String get version => "api/v1";

  @override
  String get path => "resources";

  Future<List<SupportInfo>> getSupportList(ResourceRequest request) async {
    return SupportInfo.fromJsonDecode(await getAsync(createUri(path)));
  }
}
