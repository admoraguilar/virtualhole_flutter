import 'package:flutter/material.dart';
import 'package:virtualhole_flutter/client/ui/ui.dart';
import 'package:virtualhole_flutter/midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_flutter/client/pages/pages.dart';
import 'package:virtualhole_flutter/client/configs/app_config.dart' as config;

class AppFlow {
  List<FlowPage> generateInitialPages() {
    return [
      generateDiscoverPage(),
    ];
  }

  List<FlowPage> generateRootPages() {
    return [
      generateDiscoverPage(),
      generateTestPage(),
      generateTestPage(),
      generateSupportPage(),
    ];
  }

  List<BottomNavigationBarItem> generateBottomNavigationBarItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.explore),
        label: 'Discover',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.list),
        label: 'Feed',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: 'Search',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        label: 'Support',
      ),
    ];
  }

  FlowPage generateDiscoverPage() {
    return FlowPage(
      key: UniqueKey(),
      name: '/discover',
      designType: FlowDesignType.Material,
      child: RootScaffold(
        title: '${config.kAppName}',
        body: DiscoverPage(
          key: GlobalKey<NavigatorState>(),
        ),
        pages: generateRootPages(),
        bottomNavigationBarItems: generateBottomNavigationBarItems(),
      ),
    );
  }

  FlowPage generateSupportPage() {
    return FlowPage(
      key: UniqueKey(),
      name: '/support',
      designType: FlowDesignType.Material,
      child: RootScaffold(
        title: '${config.kAppName}',
        body: SupportPage(
          key: GlobalKey<NavigatorState>(),
        ),
        pages: generateRootPages(),
        bottomNavigationBarItems: generateBottomNavigationBarItems(),
      ),
    );
  }

  FlowPage generateTestPage() {
    return FlowPage(
      key: UniqueKey(),
      name: '/test',
      designType: FlowDesignType.Material,
      child: Center(
        child: Text('Hello!!'),
      ),
    );
  }

  FlowPage generateCounterPage() {
    return FlowPage(
      key: UniqueKey(),
      name: '/counter',
      designType: FlowDesignType.Material,
      child: RootScaffold(
        title: '${config.kAppName}',
        body: CounterScreen(
          key: GlobalKey<NavigatorState>(),
          onExtraTap: () {
            FlowHandler.get().routerDelegate.setDirty(() {
              FlowHandler.get().routerDelegate.pages.add(generateCounterPage());
            });
          },
        ),
        pages: generateRootPages(),
        bottomNavigationBarItems: generateBottomNavigationBarItems(),
      ),
    );
  }

  FlowPage generateErrorPage() {
    return FlowPage(
      key: UniqueKey(),
      name: '/error',
      designType: FlowDesignType.Material,
      child: Center(
        key: GlobalKey<NavigatorState>(),
        child: Text('404 ERROR!!'),
      ),
    );
  }
}
