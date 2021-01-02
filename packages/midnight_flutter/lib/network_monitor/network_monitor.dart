import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import '../midnight_flutter.dart';

// Some code snippets from:
// package:connectivity: https://pub.dev/packages/connectivity/example
// package:data_connection_checker: https://pub.dev/packages/data_connection_checker
class NetworkMonitor {
  static NetworkMonitor _instance;

  NetworkMonitor._();

  final Connectivity _connectivity = Connectivity();

  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  ConnectivityResult _connectivityType = ConnectivityResult.none;

  NetworkMonitorStatus get status => __status;
  set _status(NetworkMonitorStatus value) {
    __status = value;
    _onStatusChanged.sink.add(__status);
  }

  NetworkMonitorStatus __status;

  Stream<NetworkMonitorStatus> get onStatusChange => _onStatusChanged.stream;
  StreamController<NetworkMonitorStatus> _onStatusChanged;

  factory NetworkMonitor() {
    if (_instance == null) {
      _instance = NetworkMonitor._();
    }
    return _instance;
  }

  Future<void> init() async {
    _onStatusChanged = StreamController<NetworkMonitorStatus>.broadcast();

    await _initConnectivityAsync();
    _connectivitySubscription = _connectivity.onConnectivityChanged
        .listen(_updateConnectionStatusAsync);
  }

  void dispose() {
    _onStatusChanged.close();
    _connectivitySubscription.cancel();
  }

  Future<void> _initConnectivityAsync() async {
    _status = NetworkMonitorStatus.checking;

    ConnectivityResult result;
    result = await _connectivity.checkConnectivity();

    MLog.log('Initializing connectivity', prepend: runtimeType);
    return _updateConnectionStatusAsync(result);
  }

  Future<void> _updateConnectionStatusAsync(ConnectivityResult result) async {
    _status = NetworkMonitorStatus.checking;
    _connectivityType = result;

    bool isAvailable;
    if (_connectivityType != ConnectivityResult.none) {
      isAvailable = await DataConnectionChecker().hasConnection;
    } else {
      isAvailable = false;
    }

    _status = isAvailable
        ? NetworkMonitorStatus.connected
        : NetworkMonitorStatus.disconnected;
    MLog.log(
      'Updating connectivity: $_connectivityType | $__status',
      prepend: runtimeType,
    );
  }
}

enum NetworkMonitorStatus {
  checking,
  connected,
  disconnected,
}
