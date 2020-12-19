import 'package:flutter/material.dart';
import 'package:virtualhole_flutter/midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_flutter/client/configs/configs.dart';
import 'package:virtualhole_flutter/client/ui/ui.dart';
import 'package:virtualhole_flutter/client/pages/pages.dart';

class DiscoverFlowPage<T> extends FlowPage<T> {
  DiscoverFlowPage()
      : super(
          key: UniqueKey(),
          name: '/discover',
          designType: FlowDesignType.Material,
          child: RootScaffold(
            title: '${AppConfig.appName}',
            body: DiscoverPage(
              key: GlobalKey<NavigatorState>(),
            ),
            pageBuilder: () => RootFlowPageHelper.generateRootPages(),
            bottomNavigationBarItems:
                RootFlowPageHelper.generateBottomNavigationBarItems(),
            bottomNavigationBarIndex: 0,
          ),
        );
}
