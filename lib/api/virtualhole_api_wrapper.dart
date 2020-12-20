import 'package:flutter/foundation.dart';
import 'package:virtualhole_flutter/api/api.dart';

class VirtualHoleApiWrapperClient {
  VirtualHoleApiWrapperClient({
    @required this.contents,
    @required this.creators,
    @required this.resources,
  });

  VirtualHoleApiWrapperClient.managed({
    @required String domain,
  })  : contents = ContentsClient(domain: domain),
        creators = CreatorsClient(domain: domain),
        resources = ResourcesClient(domain: domain);

  final ContentsClient contents;
  final CreatorsClient creators;
  final ResourcesClient resources;
}
