import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FlowHandler extends StatelessWidget {
  FlowHandler({
    Key key,
    this.builder,
    this.title,
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
    this.supportedLocales,
    this.showPerformanceOverlay,
    this.checkerboardRasterCacheImages,
    this.checkerboardOffscreenLayers,
    this.showSemanticsDebugger,
    this.debugShowCheckedModeBanner,
    this.shortcuts,
    this.actions,
    this.debugShowMaterialGrid,
  }) : super(
          key: key,
        );

  final Widget Function(
          BuildContext context, FlowHandlerRouterDelegateParameters parameters)
      builder;

  final String title;
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
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;
  final Map<LogicalKeySet, Intent> shortcuts;
  final Map<Type, Action<Intent>> actions;
  final bool debugShowMaterialGrid;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: FlowHandlerRouterDelegate(
        builder: builder,
      ),
      routeInformationParser: FlowHandlerRouteInformationParser(),
      backButtonDispatcher: RootBackButtonDispatcher(),
      title: title,
      theme: theme,
      darkTheme: darkTheme,
      highContrastTheme: highContrastTheme,
      highContrastDarkTheme: highContrastDarkTheme,
      themeMode: themeMode,
      color: color,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      localeListResolutionCallback: localeListResolutionCallback,
      localeResolutionCallback: localeResolutionCallback,
      supportedLocales: supportedLocales,
      showPerformanceOverlay: showPerformanceOverlay,
      checkerboardRasterCacheImages: checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: checkerboardOffscreenLayers,
      showSemanticsDebugger: showSemanticsDebugger,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      shortcuts: shortcuts,
      actions: actions,
      debugShowMaterialGrid: debugShowMaterialGrid,
    );
  }
}

class FlowHandlerRouterDelegate extends RouterDelegate<FlowHandlerRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<FlowHandlerRoutePath> {
  FlowHandlerRouterDelegate({
    this.builder,
  });

  final Widget Function(
          BuildContext context, FlowHandlerRouterDelegateParameters parameters)
      builder;

  @override
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();

  @override
  Future<void> setNewRoutePath(FlowHandlerRoutePath configuration) async {
    notifyListeners();
    return SynchronousFuture<void>(null);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          key: ValueKey('root'),
          child: builder(
              context,
              FlowHandlerRouterDelegateParameters(
                navigatorKey: navigatorKey,
              )),
        )
      ],
      onPopPage: (Route<dynamic> route, dynamic result) {
        print('[Flow Handler] Pop root navigator.');
        return false;
      },
    );
  }
}

class FlowHandlerRouterDelegateParameters {
  FlowHandlerRouterDelegateParameters({
    this.navigatorKey,
  });

  final GlobalKey<NavigatorState> navigatorKey;
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
  });

  final String location;
}
