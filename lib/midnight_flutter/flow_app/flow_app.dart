import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:virtualhole_flutter/midnight_flutter/flow_app/flow_handler.dart';
import 'flow_scaffold.dart';

FlowAppState _flowAppStateTransient;

class FlowApp extends StatefulWidget {
  FlowApp({
    Key key,
    @required this.initialPages,
  })  : assert(initialPages != null),
        super(key: key);

  final List<FlowAppPage> initialPages;

  @override
  State<StatefulWidget> createState() => FlowAppState();
}

class FlowAppState extends State<FlowApp> {
  List<FlowAppPage> pages = [];

  Future<bool> handleBackButton() {
    if (pages.length > 1) {
      setState(() {
        pages.removeLast();
      });
      print('page count: ${pages.length}');
      return SynchronousFuture<bool>(true);
    }
    return SynchronousFuture<bool>(false);
  }

  void triggerSetState(Function() fn) {
    setState(fn);
  }

  @override
  void initState() {
    super.initState();
    pages.addAll(widget.initialPages);
  }

  @override
  Widget build(BuildContext context) {
    _flowAppStateTransient = this;

    FlowAppPage topPage = pages.length > 0 ? pages.last : null;
    if (topPage != null) {
      return FlowScaffold(
        pages: pages,
        scaffoldSettings: topPage.scaffoldSettings,
        handlerSettings: topPage.handlerSettings,
      );
    } else {
      return Center(
        child: Text('Page stack is empty!'),
      );
    }
  }
}

class FlowAppPage<T> extends FlowPage<T> {
  FlowAppPage({
    FlowHandlerSettings Function(FlowAppState) handlerSettingsBuilder,
    FlowScaffoldSettings Function(FlowAppState) scaffoldSettingsBuilder,
    Widget Function(FlowAppState) builder,
    LocalKey key,
    String name,
    Object arguments,
  })  : assert(handlerSettingsBuilder != null),
        assert(scaffoldSettingsBuilder != null),
        assert(builder != null),
        _handlerSettingsBuilder = handlerSettingsBuilder,
        _scaffoldSettingsBuilder = scaffoldSettingsBuilder,
        _builder = builder,
        super(
          key: key,
          name: name,
          arguments: arguments,
        );

  @override
  FlowHandlerSettings get handlerSettings =>
      _handlerSettingsBuilder(_flowAppStateTransient);
  final FlowHandlerSettings Function(FlowAppState) _handlerSettingsBuilder;

  @override
  FlowScaffoldSettings get scaffoldSettings =>
      _scaffoldSettingsBuilder(_flowAppStateTransient);
  final FlowScaffoldSettings Function(FlowAppState) _scaffoldSettingsBuilder;

  @override
  Widget get builder => _builder(_flowAppStateTransient);
  final Widget Function(FlowAppState) _builder;
}
