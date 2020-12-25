import 'package:flutter/foundation.dart';
import 'package:virtualhole_flutter/midnight_flutter/midnight_flutter.dart';
import 'configs/configs.dart';

Future<void> main() async {
  MLog.log(
    'Starting ${AppConfig.appName}... [Debug: $kDebugMode]',
    prepend: 'Main',
  );

  AppViewModel().registerViewModels();
  AppFlowHandler().runFlow();
}
