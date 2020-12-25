import 'package:flutter/foundation.dart';
import 'virtualhole_api_client_dart.dart';

class VirtualHoleApiClient {
  VirtualHoleApiClient({
    @required this.contents,
    @required this.creators,
    @required this.resources,
  });

  VirtualHoleApiClient.managed({
    @required String domain,
  })  : contents = ContentsClient(domain: domain),
        creators = CreatorsClient(domain: domain),
        resources = ResourcesClient(domain: domain);

  final ContentsClient contents;
  final CreatorsClient creators;
  final ResourcesClient resources;
}
