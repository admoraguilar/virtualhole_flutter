import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

FlowHandler _flowHandler;

class FlowHandler extends StatelessWidget {
  static FlowHandler get() {
    if (_flowHandler == null) {
      throw Exception('[Flow Handler] No current instance of FlowHandler');
    }
    return _flowHandler;
  }

  FlowHandler({
    Key key,
    @required this.designType,
    @required List<FlowPage> initialPages,
    @required this.settings,
  })  : assert(designType != null),
        assert(initialPages != null && initialPages.length > 0),
        assert(settings != null),
        routerDelegate = FlowHandlerRouterDelegate(
          designType: designType,
          pages: initialPages,
          onDeviceBackButtonPressed: settings.onDeviceBackButtonPressed,
          onSetNewRoutePath: settings.onSetNewRoutePath,
        ),
        routeInformationParser = FlowHandlerRouteInformationParser(),
        backButtonDispatcher = RootBackButtonDispatcher(),
        super(key: key) {
    if (_flowHandler != null) {
      throw Exception(
          '[Flow Handler] There could only be one Flow Handler in the entire widget tree.');
    }
    _flowHandler = this;
  }

  final FlowDesignType designType;
  final FlowHandlerSettings settings;
  final FlowHandlerRouterDelegate routerDelegate;
  final RouteInformationParser routeInformationParser;
  final BackButtonDispatcher backButtonDispatcher;

  @override
  Widget build(BuildContext context) {
    if (designType == FlowDesignType.Material) {
      return MaterialApp.router(
        routerDelegate: routerDelegate,
        routeInformationParser: routeInformationParser,
        backButtonDispatcher: backButtonDispatcher,
        title: settings.title,
        onGenerateTitle: settings.onGenerateTitle,
        theme: settings.theme,
        darkTheme: settings.darkTheme,
        highContrastTheme: settings.highContrastTheme,
        highContrastDarkTheme: settings.highContrastDarkTheme,
        themeMode: settings.themeMode,
        color: settings.color,
        locale: settings.locale,
        localizationsDelegates: settings.localizationsDelegates,
        localeListResolutionCallback: settings.localeListResolutionCallback,
        localeResolutionCallback: settings.localeResolutionCallback,
        supportedLocales: settings.supportedLocales,
        showPerformanceOverlay: settings.showPerformanceOverlay,
        checkerboardRasterCacheImages: settings.checkerboardRasterCacheImages,
        checkerboardOffscreenLayers: settings.checkerboardOffscreenLayers,
        showSemanticsDebugger: settings.showSemanticsDebugger,
        debugShowCheckedModeBanner: settings.debugShowCheckedModeBanner,
        shortcuts: settings.shortcuts,
        actions: settings.actions,
        debugShowMaterialGrid: settings.debugShowMaterialGrid,
      );
    } else if (designType == FlowDesignType.Cupertino) {
      return CupertinoApp.router(
        routerDelegate: routerDelegate,
        routeInformationParser: routeInformationParser,
        backButtonDispatcher: backButtonDispatcher,
        title: settings.title,
        onGenerateTitle: settings.onGenerateTitle,
        color: settings.color,
        locale: settings.locale,
        localizationsDelegates: settings.localizationsDelegates,
        localeListResolutionCallback: settings.localeListResolutionCallback,
        localeResolutionCallback: settings.localeResolutionCallback,
        supportedLocales: settings.supportedLocales,
        showPerformanceOverlay: settings.showPerformanceOverlay,
        checkerboardRasterCacheImages: settings.checkerboardRasterCacheImages,
        checkerboardOffscreenLayers: settings.checkerboardOffscreenLayers,
        showSemanticsDebugger: settings.showSemanticsDebugger,
        debugShowCheckedModeBanner: settings.debugShowCheckedModeBanner,
        shortcuts: settings.shortcuts,
        actions: settings.actions,
      );
    }

    throw Exception('[Flow Handler] Unsupported flow design type.');
  }
}

class FlowHandlerSettings {
  FlowHandlerSettings({
    this.title,
    this.onGenerateTitle,
    this.theme,
    this.darkTheme,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.themeMode,
    this.color,
    this.locale,
    this.localizationsDelegates,
    this.localeResolutionCallback,
    this.localeListResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.onDeviceBackButtonPressed,
    this.onSetNewRoutePath,
  })  : assert(title != null),
        assert(debugShowMaterialGrid != null),
        assert(showPerformanceOverlay != null),
        assert(checkerboardRasterCacheImages != null),
        assert(checkerboardOffscreenLayers != null),
        assert(showSemanticsDebugger != null),
        assert(debugShowCheckedModeBanner != null);

  final String title;
  final String Function(BuildContext) onGenerateTitle;
  final ThemeData theme;
  final ThemeData darkTheme;
  final ThemeData highContrastTheme;
  final ThemeData highContrastDarkTheme;
  final ThemeMode themeMode;
  final Color color;
  final Locale locale;
  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;
  final LocaleListResolutionCallback localeListResolutionCallback;
  final LocaleResolutionCallback localeResolutionCallback;
  final Iterable<Locale> supportedLocales;
  final bool debugShowMaterialGrid;
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;
  final Map<LogicalKeySet, Intent> shortcuts;
  final Map<Type, Action<Intent>> actions;
  final Future<bool> Function() onDeviceBackButtonPressed;
  final Future<void> Function(FlowHandlerRoutePath) onSetNewRoutePath;
}

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
    print('[Flow Handler] Set new route path: ${configuration.location}.');
    if (onSetNewRoutePath != null) {
      onSetNewRoutePath(configuration);
      notifyListeners();
    }
    return SynchronousFuture<void>(null);
  }

  @override
  Future<bool> popRoute() {
    print('[Flow Handler] Back button dispatcher pop.');

    if (onDeviceBackButtonPressed != null) {
      Future<bool> result = onDeviceBackButtonPressed();
      notifyListeners();
      return result;
    } else {
      if (pages.length > 1) {
        pages.removeLast();
        notifyListeners();
        print('[Flow App State] Page count: ${pages.length}');
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
            print('[Flow Handler] Navigator pop.');

            bool didPop = route.didPop(result);
            pages.removeLast();
            notifyListeners();

            return didPop;
          },
        );
      }

      throw Exception(
          "[Flow App State] Page stack is empty! Make sure initial pages are not empty or that you're not emptying the page stack.");
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
        print('[Flow Handler] Navigator pop.');
        return route.didPop(result);
      },
    );
  }
}

class FlowHandlerRouteInformationParser
    extends RouteInformationParser<FlowHandlerRoutePath> {
  @override
  Future<FlowHandlerRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    // This doesn't handle web at the moment
    return FlowHandlerRoutePath(location: routeInformation.location);
  }

  @override
  RouteInformation restoreRouteInformation(FlowHandlerRoutePath configuration) {
    return RouteInformation(location: configuration.location);
  }
}

class FlowHandlerRoutePath {
  FlowHandlerRoutePath({
    this.location,
  }) : assert(location != null || location.isNotEmpty);

  final String location;
}

class FlowPage<T> extends Page<T> {
  FlowPage({
    @required this.designType,
    @required this.child,
    LocalKey key,
    String name,
    Object arguments,
  })  : assert(designType != null),
        assert(child != null),
        super(
          key: key ?? UniqueKey(),
          name: name,
          arguments: arguments,
        );

  final FlowDesignType designType;
  final Widget child;

  @override
  Route<T> createRoute(BuildContext context) {
    if (designType == FlowDesignType.Material) {
      return MaterialPage(
        key: key,
        name: name,
        arguments: arguments,
        child: child,
      ).createRoute(context);
    } else if (designType == FlowDesignType.Cupertino) {
      return CupertinoPage(
        key: key,
        title: name,
        name: name,
        arguments: arguments,
        child: child,
      ).createRoute(context);
    }

    throw Exception('[Flow Page] Unsupported flow design type.');
  }
}

enum FlowDesignType {
  Material,
  Cupertino,
}
