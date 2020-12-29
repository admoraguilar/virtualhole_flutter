import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../midnight_flutter.dart';

part 'flow_map.dart';

class FlowApp extends StatefulWidget {
  static FlowAppState of(BuildContext context) {
    FlowAppState flowApp = context.findAncestorStateOfType<FlowAppState>();
    assert(() {
      if (flowApp == null) {
        throw FlutterError(
            '${(FlowApp)} operation requested with a context that does not include a ${(FlowApp)}.\n');
      }
      return true;
    }());
    return flowApp;
  }

  FlowApp({
    Key key,
    this.initialPages,
    this.onSetNewRoutePath,
    this.initialContext,
    this.map,
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
  }) : super(key: key);

  final List<FlowPage> initialPages;
  final Function(FlowRoutePath) onSetNewRoutePath;
  final FlowContext initialContext;
  final FlowMap map;
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

  @override
  FlowAppState createState() => FlowAppState();
}

class FlowAppState extends State<FlowApp> {
  FlowRouterDelegate get routerDelegate => _routerDelegate;
  FlowRouterDelegate _routerDelegate;

  FlowRouteInformationParser get routeInformationParser =>
      _routeInformationParser;
  FlowRouteInformationParser _routeInformationParser;

  BackButtonDispatcher get backButtonDispatcher => _backButtonDispatcher;
  BackButtonDispatcher _backButtonDispatcher;

  FlowMap get map => _map;
  FlowMap _map;

  @override
  Widget build(BuildContext context) {
    _routerDelegate = FlowRouterDelegate(
      pages: widget.initialPages,
      onSetNewRoutePath: widget.onSetNewRoutePath,
    );
    _routeInformationParser = FlowRouteInformationParser();
    _backButtonDispatcher = RootBackButtonDispatcher();
    _map = widget.map;
    _map._routerDelegate = _routerDelegate;
    _map.navigate(widget.initialContext);

    return MaterialApp.router(
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
      backButtonDispatcher: _backButtonDispatcher,
      title: widget.title,
      onGenerateTitle: widget.onGenerateTitle,
      theme: widget.theme,
      darkTheme: widget.darkTheme,
      highContrastTheme: widget.highContrastTheme,
      highContrastDarkTheme: widget.highContrastDarkTheme,
      themeMode: widget.themeMode,
      color: widget.color,
      locale: widget.locale,
      localizationsDelegates: widget.localizationsDelegates,
      localeListResolutionCallback: widget.localeListResolutionCallback,
      localeResolutionCallback: widget.localeResolutionCallback,
      supportedLocales: widget.supportedLocales,
      showPerformanceOverlay: widget.showPerformanceOverlay,
      checkerboardRasterCacheImages: widget.checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: widget.checkerboardOffscreenLayers,
      showSemanticsDebugger: widget.showSemanticsDebugger,
      debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
      shortcuts: widget.shortcuts,
      actions: widget.actions,
      debugShowMaterialGrid: widget.debugShowMaterialGrid,
    );
  }
}
