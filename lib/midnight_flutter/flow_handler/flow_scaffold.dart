import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'flow_handler.dart';

class FlowScaffold extends StatefulWidget {
  FlowScaffold({
    Key key,
    this.pages,
    this.appBar,
    this.bottomNavigationBar,
  }) : super(
          key: key,
        );

  final AppBar appBar;
  final List<Page<dynamic>> pages;
  final BottomNavigationBar bottomNavigationBar;

  @override
  _FlowScaffoldState createState() => _FlowScaffoldState();
}

class _FlowScaffoldState extends State<FlowScaffold> {
  @override
  Widget build(BuildContext context) {
    return FlowHandler(builder:
        (BuildContext context, FlowHandlerRouterDelegateParameters parameters) {
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
        bottomNavigationBar: widget.bottomNavigationBar,
      );
    });
  }
}
