import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import '../midnight_flutter.dart';

// Some code snippets from:
// package:connectivity: https://pub.dev/packages/connectivity/example
// package:data_connection_checker: https://pub.dev/packages/data_connection_checker
//
//
// Sample:
// Network-resilient test
// runApp(MaterialApp(
//   home: Scaffold(
//     appBar: AppBar(
//       title: Text('Network Resilience Test'),
//     ),
//     body: NetworkResilientWidget(
//       networkChecking: Center(
//         child: Text('Checking network connection... 🤔'),
//       ),
//       networkError: Center(
//         child: Text('No internet connection! 😞'),
//       ),
//       child: Center(
//         child: Text('Happy with internet connection!!! 😄'),
//       ),
//     ),
//   ),
// ));
class NetworkResilientWidget extends StatefulWidget {
  NetworkResilientWidget({
    Key key,
    @required this.networkChecking,
    @required this.networkError,
    @required this.child,
  }) : super(key: key);

  final Widget networkChecking;
  final Widget networkError;
  final Widget child;

  @override
  _NetworkResilientWidgetState createState() => _NetworkResilientWidgetState();
}

class _NetworkResilientWidgetState extends State<NetworkResilientWidget> {
  final Connectivity _connectivity = Connectivity();

  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  ConnectivityResult _connectivityType = ConnectivityResult.none;
  bool _isConnectivitySuccess = false;
  bool _isCheckingConnectivity = false;

  @override
  void initState() {
    super.initState();
    _initConnectivityAsync();
    _connectivitySubscription = _connectivity.onConnectivityChanged
        .listen(_updateConnectionStatusAsync);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isCheckingConnectivity) {
      return widget.networkChecking;
    }

    if (_connectivityType != ConnectivityResult.none &&
        _isConnectivitySuccess) {
      return widget.child;
    }

    return widget.networkError;
  }

  Future<void> _initConnectivityAsync() async {
    _isCheckingConnectivity = true;

    ConnectivityResult result;

    // Platform messages are asynchronous, so we initialize in an async method.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      MLog.log(e);
    }

    // If the widget was removed from the tree while the asynchronous
    // platform message was in flight, we want to discard the reply rather
    // than calling setState to update the non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    MLog.log('Initializing connectivity', prepend: (NetworkResilientWidget));
    return _updateConnectionStatusAsync(result);
  }

  Future<void> _updateConnectionStatusAsync(ConnectivityResult result) async {
    _isCheckingConnectivity = true;
    _connectivityType = result;

    setState(() {});

    if (_connectivityType != ConnectivityResult.none) {
      _isConnectivitySuccess = await DataConnectionChecker().hasConnection;
    } else {
      _isConnectivitySuccess = false;
    }

    _isCheckingConnectivity = false;

    setState(() {});

    MLog.log(
        'Updating connectivity: $_connectivityType | $_isConnectivitySuccess',
        prepend: (NetworkResilientWidget));
  }
}
