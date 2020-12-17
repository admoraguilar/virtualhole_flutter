import 'package:flutter/foundation.dart';
import 'package:virtualhole_flutter/midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_flutter/api/virtualhole_api_wrapper.dart';

class SupportListViewModel extends ViewModel {
  SupportListViewModel({
    @required this.resourcesClient,
  });

  final ResourcesClient resourcesClient;
}
