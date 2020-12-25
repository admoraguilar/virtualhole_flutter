import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'flow_design_type.dart';
import 'flow_handler_router_delegate.dart';
import 'flow_handler_settings.dart';
import 'flow_page.dart';
import 'flow_route_information_parser.dart';

export 'package:virtualhole_flutter/midnight_flutter/flow_handler/flow_design_type.dart';
export 'package:virtualhole_flutter/midnight_flutter/flow_handler/flow_handler_router_delegate.dart';
export 'package:virtualhole_flutter/midnight_flutter/flow_handler/flow_handler_settings.dart';
export 'package:virtualhole_flutter/midnight_flutter/flow_handler/flow_page.dart';
export 'package:virtualhole_flutter/midnight_flutter/flow_handler/flow_route_information_parser.dart';
export 'package:virtualhole_flutter/midnight_flutter/flow_handler/flow_route_path.dart';

class FlowHandler extends StatelessWidget {
  static FlowHandler _flowHandler;

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
          '[${(FlowHandler).toString()}] There could only be one Flow Handler in the entire widget tree.');
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

    throw Exception(
        '[${(FlowHandler).toString()}] Unsupported flow design type.');
  }
}
