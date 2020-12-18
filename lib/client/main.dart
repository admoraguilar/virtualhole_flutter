import 'package:flutter/material.dart';
import 'package:virtualhole_flutter/midnight_flutter/midnight_flutter.dart';
import 'pages/pages.dart';

Future<void> main() async {
  print('Starting app...');
  runApp(FlowApp(initialPages: [
    createDiscoverPage(),
  ]));
}
