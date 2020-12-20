import 'package:flutter/material.dart';
import 'package:virtualhole_flutter/midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_flutter/client/configs/configs.dart';
import 'package:virtualhole_flutter/client/ui/ui.dart';
import 'package:virtualhole_flutter/client/pages/pages.dart';

class HomeFlowPage<T> extends FlowPage<T> {
  HomeFlowPage()
      : super(
          key: UniqueKey(),
          name: '/home',
          designType: FlowDesignType.Material,
          child: RootScaffold(
            key: GlobalKey<NavigatorState>(),
            title: '${AppConfig.appName}',
            body: HomePage(),
            pageBuilder: () => RootFlowPageHelper.generateRootPages(),
            bottomNavigationBarItems:
                RootFlowPageHelper.generateBottomNavigationBarItems(),
            bottomNavigationBarIndex: 0,
          ),
        );
}
