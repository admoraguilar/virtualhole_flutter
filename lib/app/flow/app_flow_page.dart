import 'package:flutter/material.dart';
import 'package:virtualhole_flutter/api/common/api_request.dart';
import 'package:virtualhole_flutter/midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_flutter/app/app_config.dart' as config;

class AppFlowPage {
  AppFlowPage({
    this.key,
    this.name,
    this.designType,
    this.scaffoldSettings,
    this.bottomNavigationBar,
    this.child,
  });

  final Key key;
  final String name;
  final FlowDesignType designType;
  final FlowScaffoldSettings scaffoldSettings;
  final BottomNavigationBar bottomNavigationBar;
  final Widget child;

  factory AppFlowPage.managed({
    Key key,
    String name,
    FlowDesignType designType,
    FlowScaffoldSettings scaffoldSettings,
    BottomNavigationBar bottomNavigationBar,
    Widget child,
  }) {
    scaffoldSettings ??= FlowScaffoldSettings(
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

    return AppFlowPage(
      key: key,
      name: name,
      designType: designType,
      scaffoldSettings: scaffoldSettings,
      bottomNavigationBar: bottomNavigationBar,
      child: child,
    );
  }

  FlowPage create() {
    return FlowPage(
      key: UniqueKey(),
      name: name,
      designType: designType,
      scaffoldSettings: scaffoldSettings,
      child: child,
    );
  }
}
