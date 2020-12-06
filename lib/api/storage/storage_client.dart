import 'package:flutter/foundation.dart';
import 'static/static_client.dart';
import 'dynamic/dynamic_client.dart';

export 'static/static_client.dart';
export 'dynamic/dynamic_client.dart';

class StorageClient {
  StorageClient({
    @required String domain,
    DynamicClient dynamicClient,
    StaticClient staticClient,
  })  : assert(domain.isNotEmpty),
        dynamic = dynamicClient ?? DynamicClient(domain: domain),
        static = staticClient ?? StaticClient(domain: domain);

  final DynamicClient dynamic;
  final StaticClient static;
}
