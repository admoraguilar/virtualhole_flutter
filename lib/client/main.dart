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

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlowHandler(
      title: appConfig.virtualHoleApi,
      builder: AppPage(),
      theme: ThemeData(
        primaryColor: Colors.blue[900],
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}
