import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      key: GlobalKey<NavigatorState>(),
      child: Text('404 ERROR!!'),
    );
  }
}
