import 'package:flutter/material.dart';
import 'package:virtualhole_flutter/client/configs/app_viewmodel.dart';
import 'package:virtualhole_flutter/midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_flutter/api/virtualhole_api_wrapper.dart';
import 'package:virtualhole_flutter/client/pages/pages.dart';
import 'configs/configs.dart';

void registerViewModels() {
  VirtualHoleApiWrapperClient vHoleApi =
      VirtualHoleApiWrapperClient.managed(domain: AppConfig.virtualHoleApi);

  ViewModel.add(SupportListViewModel(resourcesClient: vHoleApi.resources));
}

Future<void> main() async {
  print('Starting app...');

  AppViewModel().registerViewModels();

  runApp(
    FlowHandler(
      designType: FlowDesignType.Material,
      initialPages: RootFlowPageHelper.generateInitialPages(),
      settings: FlowHandlerSettings(
        title: '${AppConfig.appName}',
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.lightBlue[700],
          accentColor: Colors.lightBlue[700],
          backgroundColor: Colors.black,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          ),
          scaffoldBackgroundColor: Colors.black,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.black,
          ),
        ),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
