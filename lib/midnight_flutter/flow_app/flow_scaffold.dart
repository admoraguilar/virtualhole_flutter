import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'flow_handler.dart';

class FlowScaffold extends StatefulWidget {
  FlowScaffold({
    Key key,
    this.pages,
    @required this.scaffoldSettings,
    @required this.handlerSettings,
  })  : assert(scaffoldSettings != null),
        assert(handlerSettings != null),
        super(key: key);

  final List<Page<dynamic>> pages;
  final FlowScaffoldSettings scaffoldSettings;
  final FlowHandlerSettings handlerSettings;

  @override
  _FlowScaffoldState createState() => _FlowScaffoldState();
}

class _FlowScaffoldState extends State<FlowScaffold> {
  @override
  Widget build(BuildContext context) {
    return FlowHandler(
      builder: (BuildContext context) {
        return Scaffold(
          body: Navigator(
            pages: widget.pages,
            onPopPage: (Route<dynamic> route, dynamic result) {
              print('[Flow Scaffold] Pop scaffold navigator.');

              bool didPop = route.didPop(result);
              widget.pages.removeLast();
              setState(() {});

              return didPop;
            },
          ),
          appBar: widget.scaffoldSettings.appBar,
          floatingActionButton: widget.scaffoldSettings.floatingActionButton,
          floatingActionButtonLocation:
              widget.scaffoldSettings.floatingActionButtonLocation,
          floatingActionButtonAnimator:
              widget.scaffoldSettings.floatingActionButtonAnimator,
          persistentFooterButtons:
              widget.scaffoldSettings.persistentFooterButtons,
          drawer: widget.scaffoldSettings.drawer,
          endDrawer: widget.scaffoldSettings.endDrawer,
          bottomNavigationBar: widget.scaffoldSettings.bottomNavigationBar,
          bottomSheet: widget.scaffoldSettings.bottomSheet,
          backgroundColor: widget.scaffoldSettings.backgroundColor,
          resizeToAvoidBottomPadding:
              widget.scaffoldSettings.resizeToAvoidBottomPadding,
          resizeToAvoidBottomInset:
              widget.scaffoldSettings.resizeToAvoidBottomInset,
          primary: widget.scaffoldSettings.primary,
          drawerDragStartBehavior:
              widget.scaffoldSettings.drawerDragStartBehavior,
          extendBody: widget.scaffoldSettings.extendBody,
          extendBodyBehindAppBar:
              widget.scaffoldSettings.extendBodyBehindAppBar,
          drawerScrimColor: widget.scaffoldSettings.drawerScrimColor,
          drawerEdgeDragWidth: widget.scaffoldSettings.drawerEdgeDragWidth,
          drawerEnableOpenDragGesture:
              widget.scaffoldSettings.drawerEnableOpenDragGesture,
          endDrawerEnableOpenDragGesture:
              widget.scaffoldSettings.endDrawerEnableOpenDragGesture,
        );
      },
      settings: widget.handlerSettings,
    );
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

class FlowBasicPage<T> extends FlowPage<T> {
  FlowBasicPage({
    FlowHandlerSettings handlerSettings,
    FlowScaffoldSettings scaffoldSettings,
    Widget builder,
    LocalKey key,
    String name,
    Object arguments,
  })  : assert(handlerSettings != null),
        assert(scaffoldSettings != null),
        assert(builder != null),
        _handlerSettings = handlerSettings,
        _scaffoldSettings = scaffoldSettings,
        _builder = builder,
        super(
          key: key,
          name: name,
          arguments: arguments,
        );

  @override
  FlowHandlerSettings get handlerSettings => _handlerSettings;
  final FlowHandlerSettings _handlerSettings;

  @override
  FlowScaffoldSettings get scaffoldSettings => _scaffoldSettings;
  final FlowScaffoldSettings _scaffoldSettings;

  @override
  Widget get builder => _builder;
  final Widget _builder;
}

abstract class FlowPage<T> extends Page<T> {
  FlowPage({
    LocalKey key,
    String name,
    Object arguments,
  }) : super(
          key: key,
          name: name,
          arguments: arguments,
        );

  FlowHandlerSettings get handlerSettings;
  FlowScaffoldSettings get scaffoldSettings;
  Widget get builder;

  @override
  Route<T> createRoute(BuildContext context) {
    if (handlerSettings.designType == FlowDesignType.Material) {
      return MaterialPage(
        key: key,
        name: name,
        arguments: arguments,
        child: builder,
      ).createRoute(context);
    } else if (handlerSettings.designType == FlowDesignType.Cupertino) {
      return CupertinoPage(
        key: key,
        title: name,
        name: name,
        arguments: arguments,
        child: builder,
      ).createRoute(context);
    }

    throw Exception('[Flow Page] Unsupported flow design type.');
  }
}
