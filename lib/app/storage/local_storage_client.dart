import 'package:midnight_flutter/midnight_flutter.dart';
import '../../virtualhole_client.dart';

class LocalStorageClient {
  static LocalStorageClient _localStorageClient = LocalStorageClient._();

  LocalStorageClient._();

  UserData userData;
  final LocalData<UserData> userDataClient = LocalData('userData');

  factory LocalStorageClient() {
    return _localStorageClient;
  }

  Future<void> init() async {
    await userDataClient.init();
    userData = await userDataClient.load(UserData.fromJsonDecode, UserData());
  }
}
