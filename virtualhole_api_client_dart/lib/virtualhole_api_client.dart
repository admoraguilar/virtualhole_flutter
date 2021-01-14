import 'package:flutter/foundation.dart';
import 'virtualhole_api_client_dart.dart';

class VirtualHoleApiClient {
  static Map<String, VirtualHoleApiClient> _instances = {};

  VirtualHoleApiClient({
    @required this.contents,
    @required this.creators,
    @required this.resources,
  });

  factory VirtualHoleApiClient.managed(String domain) {
    return _instances.putIfAbsent(
      domain,
      () => VirtualHoleApiClient(
        contents: ContentsClient(domain: domain),
        creators: CreatorsClient(domain: domain),
        resources: ResourcesClient(domain: domain),
      ),
    );
  }

  final ContentsClient contents;
  final CreatorsClient creators;
  final ResourcesClient resources;
}
