import 'package:flutter/material.dart';
import 'package:virtualhole_flutter/midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_flutter/api/virtualhole_api_wrapper.dart';
import 'package:virtualhole_flutter/client/config/config.dart' as config;
import 'pages/pages.dart';

Future<void> main() async {
  print('Starting app...');

  VirtualHoleApiWrapperClient vHoleApi =
      VirtualHoleApiWrapperClient.managed(domain: config.virtualHoleApi);

  ViewModel.add(SupportListViewModel(resourcesClient: vHoleApi.resources));

  runApp(
    FlowApp(initialPages: AppPage().generateInitialPages()),
  );
}
