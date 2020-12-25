import 'package:flutter/material.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import '../../configs/configs.dart';
import '../../ui/ui.dart';
import '../../pages/pages.dart';

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
