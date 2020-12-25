import 'package:midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_api_client_dart/virtualhole_api_client_dart.dart';
import '../pages/pages.dart';
import 'app_config.dart';

class AppViewModel {
  void registerViewModels() {
    VirtualHoleApiClient vHoleApi =
        VirtualHoleApiClient.managed(domain: AppConfig.virtualHoleApi);

    ViewModel.add(SupportListViewModel(resourcesClient: vHoleApi.resources));
  }
}
