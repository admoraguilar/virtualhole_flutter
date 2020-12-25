import 'package:flutter/material.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import '../../configs/configs.dart';
import '../../ui/ui.dart';
import '../../pages/pages.dart';

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
