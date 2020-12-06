import 'package:flutter/foundation.dart';
import 'package:virtualhole_flutter/api/storage/static/static_client.dart';
import 'package:virtualhole_flutter/api/virtualhole_api.dart';

class VirtualHoleStorageClient {
  VirtualHoleStorageClient({
    @required String domain,
  })  : dynamic = DynamicClient(domain: domain),
        static = StaticClient(domain: domain);

  final DynamicClient dynamic;
  final StaticClient static;
}
