import 'package:virtualhole_flutter/api/virtualhole_api.dart';

class StaticClient extends APIClient {
  StaticClient({String domain}) : super(domain: domain);

  @override
  String get path => "static";

  @override
  String get version => '';
}
