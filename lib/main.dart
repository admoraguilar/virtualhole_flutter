import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import 'configs/configs.dart';

Future<void> main() async {
  MLog.log(
    'Starting ${AppConfig.appName}... [Debug: $kDebugMode]',
    prepend: 'Main',
  );

  // AppViewModel().registerViewModels();
  // AppFlowHandler().runFlow();

  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Network Resilience Test'),
      ),
      body: NetworkResilientWidget(
        networkChecking: Center(
          child: Text('Checking network connection... 🤔'),
        ),
        networkError: Center(
          child: Text('No internet connection! 😞'),
        ),
        child: Center(
          child: Text('Happy with internet connection!!! 😄'),
        ),
      ),
    ),
  ));
}
