import 'package:virtualhole_flutter/midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_flutter/api/virtualhole_api_wrapper.dart';
import 'package:virtualhole_flutter/client/pages/pages.dart';
import 'package:virtualhole_flutter/client/configs/app_config.dart' as config;

class AppViewModel {
  void registerViewModels() {
    VirtualHoleApiWrapperClient vHoleApi =
        VirtualHoleApiWrapperClient.managed(domain: config.kVirtualHoleApi);

    ViewModel.add(SupportListViewModel(resourcesClient: vHoleApi.resources));
  }
}
