import 'package:VirtualHole/common/storage/user_data.dart';
import 'package:midnight_flutter/midnight_flutter.dart';

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
