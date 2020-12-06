import 'package:flutter/cupertino.dart';
import 'contents/content_client.dart';
import 'storage/storage_client.dart';

export 'contents/content_client.dart';
export 'storage/storage_client.dart';

class VirtualHoleApiWrapperClient {
  VirtualHoleApiWrapperClient({
    @required this.content,
    @required this.storage,
  });

  VirtualHoleApiWrapperClient.managed({
    @required String contentDomain,
    @required String storageDomain,
  })  : content = ContentClient(domain: contentDomain),
        storage = StorageClient(domain: storageDomain);

  final ContentClient content;
  final StorageClient storage;
}
