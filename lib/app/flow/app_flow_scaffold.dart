import 'package:flutter/material.dart';
import 'package:virtualhole_flutter/midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_flutter/app/app_config.dart' as config;

class AppFlowScaffold {
  AppFlowScaffold({
    this.bottomNavigationBar,
  });

  final BottomNavigationBar bottomNavigationBar;

  FlowScaffoldSettings build() {
    return FlowScaffoldSettings(
      appBar: AppBar(
        title: Text('${config.kAppName}'),
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: FlowHandler.get().routerDelegate.popRoute,
            );
          },
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
