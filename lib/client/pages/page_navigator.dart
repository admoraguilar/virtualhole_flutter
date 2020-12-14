import 'package:flutter/material.dart';
import 'package:virtualhole_flutter/client/pages/discover/discover_page.dart';
import 'package:virtualhole_flutter/client/pages/pages.dart';
import 'package:virtualhole_flutter/common/common.dart';

class PageNavigatorKey {
  static const String app = '/app';
  static const String discover = '/discover';
  static const String feed = '/feed';
  static const String search = '/search';
  static const String support = '/support';
}

class PageNavigatorViewModel extends ViewModel {
  static PageRouteInfo _generateMap(String name, Widget widget, int index) {
    return PageRouteInfo(
      route: MaterialPageRoute(
        builder: (BuildContext context) {
          print('build route widget | type: ${widget.runtimeType}');
          return widget;
        },
        maintainState: true,
        settings: RouteSettings(name: name),
      ),
      index: index,
    );
  }

  final PageNavigator root = PageNavigator(
    key: GlobalKey(),
    initialRoute: PageNavigatorKey.app,
    routeBuilder: (RouteSettings settings) {
      if (settings.name == PageNavigatorKey.app) {
        return _generateMap(PageNavigatorKey.app, AppPage(), 0);
      }

      print('no route: root');
      return null;
    },
  );

  final PageNavigator pages = PageNavigator(
    key: GlobalKey(),
    initialRoute: PageNavigatorKey.discover,
    routeBuilder: (RouteSettings settings) {
      if (settings.name == PageNavigatorKey.discover) {
        return _generateMap(PageNavigatorKey.discover, DiscoverPage(), 0);
      } else if (settings.name == PageNavigatorKey.support) {
        return _generateMap(PageNavigatorKey.support, SupportPage(), 3);
      }

      print('no route: pages=${settings.name}');
      return null;
    },
  );

  void update() {
    setState();
  }
}

class PageNavigator {
  PageNavigator({
    @required this.key,
    @required this.initialRoute,
    @required this.routeBuilder,
  });

  NavigatorState get state => key.currentState;
  final GlobalKey<NavigatorState> key;

  final String initialRoute;
  final PageRouteInfo Function(RouteSettings) routeBuilder;

  int get activeIndex {
    if (key.currentContext == null) {
      return 0;
    }

    ModalRoute modalRoute = ModalRoute.of(key.currentContext);
    PageRouteInfo info = routeBuilder.call(modalRoute.settings);

    if (info == null) {
      return 0;
    }

    _activeIndex = info.index;
    return _activeIndex;
  }

  int _activeIndex = 0;

  List<Route<dynamic>> generateInitialRoutes(String param) {
    return [
      generateRoute(RouteSettings(
        name: initialRoute,
      )),
    ];
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    if (settings.arguments == null) {
      PageRouteInfo info = routeBuilder.call(settings);
      print('generate route: ${settings.name}');
      return info.route;
    }

    return _errorRoute();
  }

  Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

class PageRouteInfo {
  PageRouteInfo({
    @required this.route,
    @required this.index,
  });

  final PageRoute route;
  final int index;
}
