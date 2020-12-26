import 'package:flutter/material.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import '../configs/configs.dart';

class AppFlowHandler {
  void runFlow() {
    runApp(
      FlowHandler(
        designType: FlowDesignType.Material,
        initialPages: _generateInitialPages(),
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

  List<FlowPage> _generateInitialPages() {
    return [AppFlowPageFactory.creator()];
  }
}
