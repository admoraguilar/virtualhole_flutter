import 'configs/configs.dart';

Future<void> main() async {
  print('[Main] Starting ${AppConfig.appName}...');

  AppViewModel().registerViewModels();
  AppFlowHandler().runFlow();
}
