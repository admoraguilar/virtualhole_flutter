import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../mlog/mlog.dart';
import 'flow_handler.dart';

class FlowHandlerRouterDelegate extends RouterDelegate<FlowHandlerRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<FlowHandlerRoutePath> {
  FlowHandlerRouterDelegate({
    @required this.designType,
    @required this.pages,
    this.onDeviceBackButtonPressed,
    this.onSetNewRoutePath,
  })  : assert(designType != null),
        assert(pages != null && pages.length > 0);

  final FlowDesignType designType;
  final Future<bool> Function() onDeviceBackButtonPressed;
  final Future<void> Function(FlowHandlerRoutePath) onSetNewRoutePath;

  List<FlowPage> pages = [];

  @override
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();

  void setDirty(Function() fn) {
    assert(fn != null);
    fn();
    notifyListeners();
  }

  @override
  Future<void> setNewRoutePath(FlowHandlerRoutePath configuration) async {
    MLog.log(
      'Set new route path: ${configuration.location}.',
      prepend: (FlowHandler).toString(),
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
      prepend: (FlowHandler).toString(),
    );

    if (onDeviceBackButtonPressed != null) {
      Future<bool> result = onDeviceBackButtonPressed();
      notifyListeners();
      return result;
    } else {
      if (pages.length > 1) {
        pages.removeLast();
        notifyListeners();
        MLog.log(
          'Page count: ${pages.length}',
          prepend: (FlowHandler).toString(),
        );
        return SynchronousFuture<bool>(true);
      }

      return super.popRoute();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget generateInnerNavigator() {
      FlowPage topPage = pages.length > 0 ? pages.last : null;
      if (topPage != null) {
        return Navigator(
          key: navigatorKey,
          pages: pages,
          onPopPage: (Route<dynamic> route, dynamic result) {
            MLog.log(
              'Navigator pop.',
              prepend: (FlowHandler).toString(),
            );

            bool didPop = route.didPop(result);
            pages.removeLast();
            notifyListeners();

            return didPop;
          },
        );
      }

      throw Exception(
          "[${(FlowHandler).toString()}] Page stack is empty! Make sure initial pages are not empty or that you're not emptying the page stack.");
    }

    LocalKey rootFlowKey = ValueKey('root');

    return Navigator(
      key: navigatorKey,
      pages: [
        if (designType == FlowDesignType.Material)
          MaterialPage(
            key: rootFlowKey,
            child: generateInnerNavigator(),
          ),
        if (designType == FlowDesignType.Cupertino)
          CupertinoPage(
            key: rootFlowKey,
            child: generateInnerNavigator(),
          ),
      ],
      onPopPage: (Route<dynamic> route, dynamic result) {
        MLog.log(
          'Navigator pop.',
          prepend: (FlowHandler).toString(),
        );
        return route.didPop(result);
      },
    );
  }
}
