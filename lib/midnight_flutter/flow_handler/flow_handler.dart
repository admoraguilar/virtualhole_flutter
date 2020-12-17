import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FlowHandler extends StatelessWidget {
  FlowHandler({
    Key key,
    this.builder,
    this.settings,
  }) : super(
          key: key,
        );

  final Widget Function(
          BuildContext context, FlowHandlerRouterDelegateParameters parameters)
      builder;

  final FlowHandlerSettings settings;

  @override
  Widget build(BuildContext context) {
    if (settings.appType == FlowHandlerAppType.Material) {
      return MaterialApp.router(
        routerDelegate: FlowHandlerRouterDelegate(
          builder: builder,
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
    } else if (settings.appType == FlowHandlerAppType.Cupertino) {
      return CupertinoApp.router(
        routerDelegate: FlowHandlerRouterDelegate(
          builder: builder,
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
    } else {
      throw Exception('[Flow Handler] Unsupported app type.');
    }
  }
}

class FlowHandlerSettings {
  FlowHandlerSettings({
    @required this.appType,
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
    this.supportedLocales,
    this.showPerformanceOverlay,
    this.checkerboardRasterCacheImages,
    this.checkerboardOffscreenLayers,
    this.showSemanticsDebugger,
    this.debugShowCheckedModeBanner,
    this.shortcuts,
    this.actions,
    this.debugShowMaterialGrid,
  });

  final FlowHandlerAppType appType;
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
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;
  final Map<LogicalKeySet, Intent> shortcuts;
  final Map<Type, Action<Intent>> actions;
  final bool debugShowMaterialGrid;
}

enum FlowHandlerAppType {
  Material,
  Cupertino,
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
