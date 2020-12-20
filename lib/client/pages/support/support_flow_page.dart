import 'package:flutter/material.dart';
import 'package:virtualhole_flutter/midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_flutter/client/configs/configs.dart';
import 'package:virtualhole_flutter/client/ui/ui.dart';
import 'package:virtualhole_flutter/client/pages/pages.dart';

class SupportFlowPage<T> extends FlowPage<T> {
  SupportFlowPage()
      : super(
          key: UniqueKey(),
          name: '/support',
          designType: FlowDesignType.Material,
          child: RootScaffold(
            key: GlobalKey<NavigatorState>(),
            title: '${AppConfig.appName}',
            body: SupportPage(),
            pageBuilder: () => RootFlowPageHelper.generateRootPages(),
            bottomNavigationBarItems:
                RootFlowPageHelper.generateBottomNavigationBarItems(),
            bottomNavigationBarIndex: 3,
          ),
        );
}
