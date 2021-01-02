part of 'flow_app.dart';

class FlowMap {
  FlowMap(List<FlowResponse> responses)
      : assert(responses != null && responses.length > 0) {
    upsertAll(responses);
  }

  Function() _onNavigateSamePage;

  Map<Type, List<FlowResponse<FlowContext>>> _map = {};
  FlowRouterDelegate _routerDelegate;
  bool _isDirty = false;

  void navigate(FlowContext context) {
    Type contextType = context.runtimeType;
    if (!_map.containsKey(contextType)) {
      MLog.log(
        'No response set for context of type: ${(context.runtimeType)}',
        prepend: (FlowMap),
      );
      return;
    }

    for (FlowResponse response in _map[contextType]) {
      if (!response.canRespond) {
        continue;
      }

      response._context = context;
      response._map = this;

      if (!_isDirty) {
        _isDirty = true;

        List<FlowPage> prevPages = _routerDelegate.pages.toList();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!listEquals(prevPages, _routerDelegate.pages)) {
            _routerDelegate.setDirty(() {});
          } else {
            if (_routerDelegate.pages.length > 0) {
              MLog.log('Navigating to same page..', prepend: runtimeType);
              _onNavigateSamePage?.call();
            }
          }
          _isDirty = false;
        });
      }

      response.respond();
      break;
    }
  }

  void upsertAll(List<FlowResponse> responses) {
    responses.forEach((r) => upsert(r));
  }

  void upsert(FlowResponse response) {
    Type contextType = response.contextType;
    _initMap(contextType);
    if (!_map[contextType].contains(response)) {
      _map[contextType].add(response);
    }
  }

  void remove(FlowResponse response) {
    Type contextType = response.contextType;
    _initMap(contextType);
    if (_map[contextType].contains(response)) {
      _map[contextType].remove(response);
    }
  }

  void _initMap(Type type) {
    if (!_map.containsKey(type)) {
      _map[type] = [];
    }
  }
}

abstract class FlowContext {}

abstract class FlowResponse<T extends FlowContext> {
  Type get contextType => T;
  T get context => _context;
  T _context;

  List<FlowPage> get pages => _map._routerDelegate.pages;
  FlowMap _map;

  bool get canRespond => true;

  void navigate(FlowContext context) {
    _map.navigate(context);
  }

  void respond();
}

class FlowMapListener extends StatefulWidget {
  FlowMapListener({
    Key key,
    this.onNavigateSamePage,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  final Function() onNavigateSamePage;
  final Widget child;

  @override
  _FlowMapListenerState createState() => _FlowMapListenerState();
}

class _FlowMapListenerState extends State<FlowMapListener> {
  FlowMap _map;

  @override
  void initState() {
    super.initState();
    _map = FlowApp.of(context).map;
  }

  @override
  void dispose() {
    if (_map._onNavigateSamePage == widget.onNavigateSamePage) {
      _map._onNavigateSamePage = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _map._onNavigateSamePage = widget.onNavigateSamePage;
    return widget.child;
  }
}
