import 'package:flutter/foundation.dart';
import 'package:virtualhole_flutter/api/storage/virtualhole_storage_client.dart';
import 'package:virtualhole_flutter/common/common.dart';
import 'package:virtualhole_flutter/api/storage/dynamic/support_info.dart';

class SupportListViewModel {
  SupportListViewModel({
    @required this.storageClient,
  });

  final VirtualHoleStorageClient storageClient;
}
