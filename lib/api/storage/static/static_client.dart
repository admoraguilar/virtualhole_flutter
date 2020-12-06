import 'package:virtualhole_flutter/api/common/api_client.dart';

class StaticClient extends APIClient {
  StaticClient({String domain})
      : assert(domain.isNotEmpty),
        super(domain: domain);

  @override
  String get path => "static";

  @override
  String get version => '';
}
