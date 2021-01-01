import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import 'virtualhole_client.dart';

Future<void> main() async {
  MLog.log(
    'Starting ${AppConfig.kAppName}... [Debug: $kDebugMode]',
    prepend: 'Main',
  );

  runApp(RootSetup());
}
