import 'package:package_info/package_info.dart';

class BuildInfoClient {
  static BuildInfoClient _buildInfoClient = BuildInfoClient._();

  String get appName => _packageInfo.appName;
  String get packageName => _packageInfo.packageName;
  String get version => _packageInfo.version;
  String get buildNumber => _packageInfo.buildNumber;

  PackageInfo _packageInfo;

  BuildInfoClient._();

  factory BuildInfoClient() {
    return _buildInfoClient;
  }

  Future<void> init() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }
}
