import 'package:virtualhole_api_client_dart/virtualhole_api_client.dart';

class ClientFactory {
  static VirtualHoleApiClient vHoleApi() {
    return VirtualHoleApiClient.managed(domain: 'www.virtualhole.app');
  }
}
