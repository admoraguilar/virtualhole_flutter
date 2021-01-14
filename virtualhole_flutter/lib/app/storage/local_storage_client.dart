import 'package:midnight_flutter/midnight_flutter.dart';
import '../../virtualhole_client.dart';

class LocalStorageClient {
  static LocalStorageClient _localStorageClient = LocalStorageClient._();

  LocalStorageClient._();

  final LocalData<UserData> _userDataClient = LocalData('userData');

  UserData userData;

  factory LocalStorageClient() {
    return _localStorageClient;
  }

  Future<void> init() async {
    await _userDataClient.init();
    userData = await _userDataClient.load(UserData.fromJsonDecode, UserData());
  }

  Future<void> write() async {
    await _userDataClient.write(userData);
  }
}
