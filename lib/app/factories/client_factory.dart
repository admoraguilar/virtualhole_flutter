import 'package:virtualhole_api_client_dart/virtualhole_api_client.dart';

class ClientFactory {
  static ClientFactory _instance;

  ClientFactory({
    VirtualHoleApiClient vHoleApi,
  }) : vHoleApi =
            vHoleApi ?? VirtualHoleApiClient.managed('www.virtualhole.app');

  final VirtualHoleApiClient vHoleApi;

  factory ClientFactory.managed() {
    if (_instance == null) {
      _instance = ClientFactory();
    }
    return _instance;
  }
}
