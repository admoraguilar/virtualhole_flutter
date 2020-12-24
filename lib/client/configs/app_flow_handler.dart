import 'package:flutter/material.dart';
import 'package:virtualhole_flutter/midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_flutter/client/pages/pages.dart';
import 'app_config.dart';

class AppFlowHandler {
  void runFlow() {
    // runApp(
    //   Image.network(
    //     'https://i.ytimg.com/vi/dtTD8SOzVU4/mqdefault.jpg',
    //     errorBuilder:
    //         (BuildContext context, Object object, StackTrace stackTrace) {
    //       print('error image load');
    //       return Text('404 ERROR');
    //     },
    //   ),
    // );

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
}
