import 'package:flutter/cupertino.dart';
import 'contents/content_client.dart';
import 'resources/resources_client.dart';

export 'contents/content_client.dart';
export 'resources/resources_client.dart';

class VirtualHoleApiWrapperClient {
  VirtualHoleApiWrapperClient({
    @required this.content,
    @required this.resources,
  });

  VirtualHoleApiWrapperClient.managed({@required String domain})
      : content = ContentClient(domain: domain),
        resources = ResourcesClient(domain: domain);

  final ContentClient content;
  final ResourcesClient resources;
}
