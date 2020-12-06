import 'package:flutter/cupertino.dart';
import 'storage/virtualhole_storage_client.dart';

export 'storage/virtualhole_storage_client.dart';

class VirtualHoleApiWrapperClient {
  VirtualHoleApiWrapperClient({
    @required this.contentsDomain,
    @required this.storageDomain,
    VirtualHoleStorageClient storage,
  })  : assert(contentsDomain.isNotEmpty),
        assert(storageDomain.isNotEmpty),
        this.storage =
            storage ?? VirtualHoleStorageClient(domain: storageDomain);

  final String contentsDomain;
  final String storageDomain;

  final VirtualHoleStorageClient storage;
}
