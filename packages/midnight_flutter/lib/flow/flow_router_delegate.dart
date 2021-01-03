import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../midnight_flutter.dart';

class FlowRouterDelegate extends RouterDelegate<FlowRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<FlowRoutePath> {
  FlowRouterDelegate({
    List<FlowPage> pages,
    this.onSetNewRoutePath,
    List<NavigatorObserver> navigatorObservers,
  })  : pages = pages ?? [],
        navigatorObservers = navigatorObservers ?? [];

  final Future<void> Function(FlowRoutePath) onSetNewRoutePath;
  final List<NavigatorObserver> navigatorObservers;

  List<FlowPage> pages = [];

  @override
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();

  void setDirty(Function() fn) {
    assert(fn != null);
    fn();
    notifyListeners();
  }

  @override
  Future<void> setNewRoutePath(FlowRoutePath configuration) async {
    MLog.log(
      'Set new route path: ${configuration.location}.',
      prepend: (FlowRouterDelegate),
    );
    if (onSetNewRoutePath != null) {
      onSetNewRoutePath(configuration);
      notifyListeners();
    }
    return SynchronousFuture<void>(null);
  }

  @override
  Future<bool> popRoute() {
    MLog.log(
      'Back button dispatcher pop.',
      prepend: (FlowRouterDelegate),
    );

    if (pages.length > 1) {
      pages.removeLast();
      notifyListeners();
      MLog.log(
        'Page count: ${pages.length}',
        prepend: (FlowRouterDelegate),
      );
      return SynchronousFuture<bool>(true);
    }

    return super.popRoute();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        FlowPage(
          key: ValueKey('root'),
          name: '/root',
          child: _generateInnerNavigator(),
        )
      ],
      onPopPage: (Route<dynamic> route, dynamic result) {
        MLog.log(
          'Root navigator pop.',
          prepend: (FlowRouterDelegate),
        );
        return route.didPop(result);
      },
    );
  }

  Widget _generateInnerNavigator() {
    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: (Route<dynamic> route, dynamic result) {
        MLog.log(
          'Inner navigator pop.',
          prepend: (FlowRouterDelegate),
        );

        bool didPop = route.didPop(result);
        pages.removeLast();
        notifyListeners();

        return didPop;
      },
      observers: navigatorObservers,
    );
  }
}
