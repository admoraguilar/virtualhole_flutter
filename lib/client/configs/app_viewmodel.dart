import 'package:virtualhole_flutter/midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_flutter/api/virtualhole_api_wrapper.dart';
import 'package:virtualhole_flutter/client/pages/pages.dart';
import 'app_config.dart';

class AppViewModel {
  void registerViewModels() {
    VirtualHoleApiWrapperClient vHoleApi =
        VirtualHoleApiWrapperClient.managed(domain: AppConfig.virtualHoleApi);

    ViewModel.add(SupportListViewModel(resourcesClient: vHoleApi.resources));
  }
}
