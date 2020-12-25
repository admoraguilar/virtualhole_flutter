import 'package:flutter/foundation.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_api_client_dart/virtualhole_api_client_dart.dart';

class SupportListViewModel extends ViewModel {
  SupportListViewModel({
    @required this.resourcesClient,
  });

  final ResourcesClient resourcesClient;
}
