import 'package:virtualhole_flutter/api/common/api_client.dart';
import 'support_info.dart';

export 'support_info.dart';

class DynamicClient extends APIClient {
  DynamicClient({String domain})
      : assert(domain.isNotEmpty),
        super(domain: domain);

  @override
  String get path => "dynamic";

  @override
  String get version => '';

  Future<List<SupportInfo>> getListSupportInfoAsync() async {
    return SupportInfo.fromJsonDecode(
        await getAsync(createUri('support-list.json')));
  }
}
