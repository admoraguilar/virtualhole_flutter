import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FlowHandler extends StatelessWidget {
  FlowHandler({
    Key key,
    @required this.builder,
    @required this.settings,
  })  : assert(builder != null),
        assert(settings != null),
        super(key: key);

  final Widget Function(BuildContext) builder;
  final FlowHandlerSettings settings;

  @override
  Widget build(BuildContext context) {
    if (settings.designType == FlowDesignType.Material) {
      return MaterialApp.router(
        routerDelegate: FlowHandlerRouterDelegate(
          designType: settings.designType,
          builder: builder,
          onDeviceBackButtonPressed: settings.onDeviceBackButtonPressed,
          onSetNewRoutePath: settings.onSetNewRoutePath,
        ),
        routeInformationParser: FlowHandlerRouteInformationParser(),
        backButtonDispatcher: RootBackButtonDispatcher(),
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
    } else if (settings.designType == FlowDesignType.Cupertino) {
      return CupertinoApp.router(
        routerDelegate: FlowHandlerRouterDelegate(
          designType: settings.designType,
          builder: builder,
          onDeviceBackButtonPressed: settings.onDeviceBackButtonPressed,
          onSetNewRoutePath: settings.onSetNewRoutePath,
        ),
        routeInformationParser: FlowHandlerRouteInformationParser(),
        backButtonDispatcher: RootBackButtonDispatcher(),
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

    throw Exception('[Flow Handler] Unsupported app type.');
  }
}

class FlowHandlerSettings {
  FlowHandlerSettings({
    @required this.designType,
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
  })  : assert(designType != null),
        assert(title != null),
        assert(debugShowMaterialGrid != null),
        assert(showPerformanceOverlay != null),
        assert(checkerboardRasterCacheImages != null),
        assert(checkerboardOffscreenLayers != null),
        assert(showSemanticsDebugger != null),
        assert(debugShowCheckedModeBanner != null);

  final FlowDesignType designType;
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

enum FlowDesignType {
  Material,
  Cupertino,
}

class FlowHandlerRouterDelegate extends RouterDelegate<FlowHandlerRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<FlowHandlerRoutePath> {
  FlowHandlerRouterDelegate({
    @required this.designType,
    @required this.builder,
    this.onDeviceBackButtonPressed,
    this.onSetNewRoutePath,
  })  : assert(designType != null),
        assert(builder != null);

  final FlowDesignType designType;
  final Widget Function(BuildContext) builder;
  final Future<bool> Function() onDeviceBackButtonPressed;
  final Future<void> Function(FlowHandlerRoutePath) onSetNewRoutePath;

  @override
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();

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
    if (onDeviceBackButtonPressed == null) {
      return super.popRoute();
    }
    return onDeviceBackButtonPressed();
  }

  @override
  Widget build(BuildContext context) {
    LocalKey rootFlowKey = ValueKey('root_flow');
    Page<dynamic> rootFlow;

    if (designType == FlowDesignType.Material) {
      rootFlow = MaterialPage(
        key: rootFlowKey,
        child: builder(
          context,
        ),
      );
    } else if (designType == FlowDesignType.Cupertino) {
      rootFlow = CupertinoPage(
        key: rootFlowKey,
        child: builder(
          context,
        ),
      );
    }

    return Navigator(
      key: navigatorKey,
      pages: [
        rootFlow,
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
