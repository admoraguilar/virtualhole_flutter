import 'package:flutter/material.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import '../../configs/configs.dart';
import '../../pages/pages.dart';

class AppFlowPageFactory {
  static FlowPage home() {
    return _generateMaterialPage(
      '/home',
      HomePage(
        key: GlobalKey<NavigatorState>(),
        contentFeedTabs: AppContentFeedTabFactory.main(),
        pageBuilder: _generateRootPage,
        bottomNavigationBarItems: AppBottomNavigationFactory.main(),
        contentFeedInitialTabIndex: 0,
      ),
    );
  }

  static FlowPage creator() {
    return _generateMaterialPage(
      '/creator',
      CreatorPage(
        key: GlobalKey<NavigatorState>(),
        creator: AppCreatorFactory.suisei(),
        contentFeedTabs: AppContentFeedTabFactory.creator([
          AppCreatorFactory.suisei(),
        ]),
        pageBuilder: _generateRootPage,
        bottomNavigationBarItems: AppBottomNavigationFactory.main(),
      ),
    );
  }

  static FlowPage counter() {
    return _generateMaterialPage(
      '/counter',
      CounterPage(
        key: GlobalKey<NavigatorState>(),
        title: Text('${AppConfig.appName}'),
        pageBuilder: _generateRootPage,
        bottomNavigationBarItems: AppBottomNavigationFactory.main(),
        onExtraTap: () {
          FlowHandler.get().routerDelegate.setDirty(
                () => FlowHandler.get().routerDelegate.pages.add(counter()),
              );
        },
      ),
    );
  }

  static FlowPage support() {
    return _generateMaterialPage(
      '/support',
      SupportPage(
        key: GlobalKey<NavigatorState>(),
        pageBuilder: _generateRootPage,
        bottomNavigationBarItems: AppBottomNavigationFactory.main(),
      ),
    );
  }

  static FlowPage error() {
    return _generateMaterialPage(
      '/error',
      ErrorPage(),
    );
  }

  static FlowPage _generateRootPage(int index) {
    if (index == 0) {
      return home();
    } else if (index == 1) {
      return counter();
    } else if (index == 2) {
      return error();
    } else if (index == 3) {
      return support();
    } else {
      return error();
    }
  }

  static FlowPage _generateMaterialPage(String name, Widget child) {
    return FlowPage(
      key: UniqueKey(),
      name: name,
      designType: FlowDesignType.Material,
      child: child,
    );
  }
}
