import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'flow_handler.dart';

class FlowScaffold extends StatefulWidget {
  FlowScaffold({
    Key key,
    @required this.handlerSettings,
    this.appBar,
    this.pages,
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
    this.drawerDragStartBehaviour = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
  }) : super(
          key: key,
        );

  final AppBar appBar;
  final List<Page<dynamic>> pages;
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
  final DragStartBehavior drawerDragStartBehaviour;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final Color drawerScrimColor;
  final double drawerEdgeDragWidth;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;

  final FlowHandlerSettings handlerSettings;

  @override
  _FlowScaffoldState createState() => _FlowScaffoldState();
}

class _FlowScaffoldState extends State<FlowScaffold> {
  @override
  Widget build(BuildContext context) {
    return FlowHandler(
      builder: (BuildContext context,
          FlowHandlerRouterDelegateParameters parameters) {
        return Scaffold(
          body: Navigator(
            key: parameters.navigatorKey,
            pages: widget.pages,
            onPopPage: (Route<dynamic> route, dynamic result) {
              print('[Flow Scaffold] Pop scaffold navigator');

              bool result = false;

              widget.pages.removeLast();
              if (!route.didPop(result)) {
                result = false;
              }

              result = true;
              setState(() {});

              return result;
            },
          ),
          appBar: widget.appBar,
          floatingActionButton: widget.floatingActionButton,
          floatingActionButtonLocation: widget.floatingActionButtonLocation,
          floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
          persistentFooterButtons: widget.persistentFooterButtons,
          drawer: widget.drawer,
          endDrawer: widget.endDrawer,
          bottomNavigationBar: widget.bottomNavigationBar,
          bottomSheet: widget.bottomSheet,
          backgroundColor: widget.backgroundColor,
          resizeToAvoidBottomPadding: widget.resizeToAvoidBottomPadding,
          resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
          primary: widget.primary,
          drawerDragStartBehavior: widget.drawerDragStartBehaviour,
          extendBody: widget.extendBody,
          extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
          drawerScrimColor: widget.drawerScrimColor,
          drawerEdgeDragWidth: widget.drawerEdgeDragWidth,
          drawerEnableOpenDragGesture: widget.drawerEnableOpenDragGesture,
          endDrawerEnableOpenDragGesture: widget.endDrawerEnableOpenDragGesture,
        );
      },
      settings: widget.handlerSettings,
    );
  }
}
