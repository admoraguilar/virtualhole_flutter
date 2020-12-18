import 'package:flutter/material.dart';
import 'package:virtualhole_flutter/midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_flutter/api/virtualhole_api_wrapper.dart';
import 'config/app_config.dart' as appConfig;
import 'pages/pages.dart';

Future<void> main() async {
  print('Starting app...');

  VirtualHoleApiWrapperClient vHoleApi = VirtualHoleApiWrapperClient.managed(
    domain: appConfig.virtualHoleApi,
  );

  ViewModel.add(SupportListViewModel(
    resourcesClient: vHoleApi.resources,
  ));

  runApp(AppPage(
    title: appConfig.appName,
  ));
}
