import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

FlowHandler _flowHandler;

class FlowHandler extends StatelessWidget {
  static FlowHandler of(BuildContext context) {
    FlowHandler flowHandler;
    flowHandler = context.findAncestorWidgetOfExactType<FlowHandler>();
    if (flowHandler == null) {
      throw Exception('[Flow Handler] No Flow Handler ancestor for context.');
    }
    return flowHandler;
  }

  static FlowHandler instance() {
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
          '[Flow Handler] There could only be one Flow Handler in the widget tree.');
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

  void triggerNotifyListeners() {
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
    Widget generateScaffold() {
      FlowPage topPage = pages.length > 0 ? pages.last : null;

      if (topPage != null) {
        return Scaffold(
          key: navigatorKey,
          body: Navigator(
            key: navigatorKey,
            pages: pages,
            onPopPage: (Route<dynamic> route, dynamic result) {
              print('[Flow Handler] Navigator pop.');

              bool didPop = route.didPop(result);
              pages.removeLast();
              notifyListeners();

              return didPop;
            },
          ),
          appBar: topPage.scaffoldSettings.appBar,
          floatingActionButton: topPage.scaffoldSettings.floatingActionButton,
          floatingActionButtonLocation:
              topPage.scaffoldSettings.floatingActionButtonLocation,
          floatingActionButtonAnimator:
              topPage.scaffoldSettings.floatingActionButtonAnimator,
          persistentFooterButtons:
              topPage.scaffoldSettings.persistentFooterButtons,
          drawer: topPage.scaffoldSettings.drawer,
          endDrawer: topPage.scaffoldSettings.endDrawer,
          bottomNavigationBar: topPage.scaffoldSettings.bottomNavigationBar,
          bottomSheet: topPage.scaffoldSettings.bottomSheet,
          backgroundColor: topPage.scaffoldSettings.backgroundColor,
          resizeToAvoidBottomPadding:
              topPage.scaffoldSettings.resizeToAvoidBottomPadding,
          resizeToAvoidBottomInset:
              topPage.scaffoldSettings.resizeToAvoidBottomInset,
          primary: topPage.scaffoldSettings.primary,
          drawerDragStartBehavior:
              topPage.scaffoldSettings.drawerDragStartBehavior,
          extendBody: topPage.scaffoldSettings.extendBody,
          extendBodyBehindAppBar:
              topPage.scaffoldSettings.extendBodyBehindAppBar,
          drawerScrimColor: topPage.scaffoldSettings.drawerScrimColor,
          drawerEdgeDragWidth: topPage.scaffoldSettings.drawerEdgeDragWidth,
          drawerEnableOpenDragGesture:
              topPage.scaffoldSettings.drawerEnableOpenDragGesture,
          endDrawerEnableOpenDragGesture:
              topPage.scaffoldSettings.endDrawerEnableOpenDragGesture,
        );
      }

      throw Exception(
          "[Flow App State] Page stack is empty! Make sure initial pages are not empty or that you're not emptying the page stack.");
    }

    LocalKey rootFlowKey = ValueKey('root_flow');
    Page<dynamic> rootFlow;

    if (designType == FlowDesignType.Material) {
      rootFlow = MaterialPage(
        key: rootFlowKey,
        child: generateScaffold(),
      );
    } else if (designType == FlowDesignType.Cupertino) {
      rootFlow = CupertinoPage(
        key: rootFlowKey,
        child: generateScaffold(),
      );
    }

    return Navigator(
      pages: [rootFlow],
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
    @required this.scaffoldSettings,
    @required this.builder,
    LocalKey key,
    String name,
    Object arguments,
  })  : assert(scaffoldSettings != null),
        assert(builder != null),
        super(
          key: key,
          name: name,
          arguments: arguments,
        );

  final FlowDesignType designType;
  final FlowScaffoldSettings scaffoldSettings;
  final Widget Function(BuildContext) builder;

  @override
  Route<T> createRoute(BuildContext context) {
    if (designType == FlowDesignType.Material) {
      return MaterialPage(
        key: key,
        name: name,
        arguments: arguments,
        child: builder(context),
      ).createRoute(context);
    } else if (designType == FlowDesignType.Cupertino) {
      return CupertinoPage(
        key: key,
        title: name,
        name: name,
        arguments: arguments,
        child: builder(context),
      ).createRoute(context);
    }

    throw Exception('[Flow Page] Unsupported flow design type.');
  }
}

class FlowScaffoldSettings {
  FlowScaffoldSettings({
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.drawer,
    this.endDrawer,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomPadding,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
  })  : assert(primary != null),
        assert(extendBody != null),
        assert(extendBodyBehindAppBar != null),
        assert(drawerDragStartBehavior != null);

  final AppBar appBar;
  final Widget floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final FloatingActionButtonAnimator floatingActionButtonAnimator;
  final List<Widget> persistentFooterButtons;
  final Widget drawer;
  final Widget endDrawer;
  final BottomNavigationBar bottomNavigationBar;
  final Widget bottomSheet;
  final Color backgroundColor;
  final bool resizeToAvoidBottomPadding;
  final bool resizeToAvoidBottomInset;
  final bool primary;
  final DragStartBehavior drawerDragStartBehavior;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final Color drawerScrimColor;
  final double drawerEdgeDragWidth;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;
}

enum FlowDesignType {
  Material,
  Cupertino,
}
