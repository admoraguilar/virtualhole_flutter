class AppConfig {
  static AppConfig _instance;

  AppConfig._();

  final String appName = 'VirtualHole';

  factory AppConfig() {
    if (_instance == null) {
      _instance = AppConfig._();
    }
    return _instance;
  }
}
