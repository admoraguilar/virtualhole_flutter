import 'package:flutter/material.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import '../../configs/configs.dart';
import '../../ui/ui.dart';
import '../../pages/pages.dart';

class HomeFlowPage<T> extends FlowPage<T> {
  HomeFlowPage._(
    Widget child,
  ) : super(
          key: UniqueKey(),
          name: '/home',
          designType: FlowDesignType.Material,
          child: child,
        );

  factory HomeFlowPage({ScrollController scrollController}) {
    scrollController ??= ScrollController();

    return HomeFlowPage._(
      RootScaffold(
        key: GlobalKey<NavigatorState>(),
        body: HomePage(
          scrollController: scrollController,
        ),
        pageBuilder: RootFlowPageHelper.generateRootPages,
        bottomNavigationBarItems:
            RootFlowPageHelper.generateBottomNavigationBarItems(),
        bottomNavigationBarIndex: 0,
        onBottomNavigateSamePage: () {
          if (scrollController.hasClients) {
            scrollController.animateTo(
              0,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeOutCirc,
            );
          }
        },
      ),
    );
  }
}
