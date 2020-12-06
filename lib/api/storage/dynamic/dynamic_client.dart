import 'package:virtualhole_flutter/api/virtualhole_api.dart';

class DynamicClient extends APIClient {
  DynamicClient({String domain}) : super(domain: domain);

  @override
  String get path => "dynamic";

  @override
  String get version => '';

  Future<List<SupportInfo>> listSupportInfoAsync() async {
    return SupportInfo.fromJsonDecode(
        await getAsync(createUri('support-list.json')));
  }
}
