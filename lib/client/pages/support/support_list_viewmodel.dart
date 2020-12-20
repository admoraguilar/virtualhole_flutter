import 'package:flutter/foundation.dart';
import 'package:virtualhole_flutter/midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_flutter/api/api.dart';

class SupportListViewModel extends ViewModel {
  SupportListViewModel({
    @required this.resourcesClient,
  });

  final ResourcesClient resourcesClient;
}
