import 'package:flutter/foundation.dart';
import 'package:virtualhole_flutter/api/virtualhole_api_wrapper.dart';
import 'package:virtualhole_flutter/common/common.dart';

class SupportListViewModel extends ViewModel {
  SupportListViewModel({
    @required this.resourcesClient,
  });

  final ResourcesClient resourcesClient;
}
