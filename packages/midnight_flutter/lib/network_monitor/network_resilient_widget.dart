import 'dart:async';
import 'package:flutter/material.dart';
import '../midnight_flutter.dart';

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
  StreamSubscription<NetworkMonitorStatus> _onStatusChangeListener;

  @override
  void initState() {
    super.initState();
    _onStatusChangeListener =
        NetworkMonitor().onStatusChange.listen((_) => setState(() {}));
  }

  @override
  void dispose() {
    _onStatusChangeListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    NetworkMonitorStatus status = NetworkMonitor().status;
    if (status == NetworkMonitorStatus.checking) {
      return widget.networkChecking;
    }

    if (status == NetworkMonitorStatus.disconnected) {
      return widget.networkError;
    }

    return widget.child;
  }
}
