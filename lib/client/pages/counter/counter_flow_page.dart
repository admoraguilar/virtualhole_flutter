import 'package:flutter/material.dart';
import 'package:virtualhole_flutter/midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_flutter/client/configs/configs.dart';
import 'package:virtualhole_flutter/client/ui/ui.dart';
import 'package:virtualhole_flutter/client/pages/pages.dart';

class CounterFlowPage<T> extends FlowPage<T> {
  CounterFlowPage()
      : super(
          key: UniqueKey(),
          name: '/counter',
          designType: FlowDesignType.Material,
          child: RootScaffold(
            title: '${AppConfig.appName}',
            body: CounterScreen(
              key: GlobalKey<NavigatorState>(),
              onExtraTap: () {
                FlowHandler.get().routerDelegate.setDirty(
                  () {
                    FlowHandler.get().routerDelegate.pages.add(
                          CounterFlowPage(),
                        );
                  },
                );
              },
            ),
            pageBuilder: () => RootFlowPageHelper.generateRootPages(),
            bottomNavigationBarItems:
                RootFlowPageHelper.generateBottomNavigationBarItems(),
            bottomNavigationBarIndex: 1,
          ),
        );
}
