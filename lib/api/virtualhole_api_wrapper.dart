import 'package:flutter/cupertino.dart';
import 'contents/contents_client.dart';
import 'creators/creator_client.dart';
import 'resources/resources_client.dart';

export 'contents/contents_client.dart';
export 'creators/creator_client.dart';
export 'resources/resources_client.dart';

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
