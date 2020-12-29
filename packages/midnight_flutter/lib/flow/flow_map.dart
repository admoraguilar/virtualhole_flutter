part of 'flow_app.dart';

class FlowMap {
  FlowMap(List<FlowResponse> responses)
      : assert(responses != null && responses.length > 0) {
    upsertAll(responses);
  }

  Map<Type, List<FlowResponse<FlowContext>>> _map = {};
  FlowRouterDelegate _routerDelegate;

  void navigate(FlowContext flowContext) {
    Type contextType = flowContext.runtimeType;
    if (!_map.containsKey(contextType)) {
      MLog.log(
        'No response set for context of type: ${(flowContext.runtimeType)}',
        prepend: (FlowMap),
      );
      return;
    }

    for (FlowResponse response in _map[contextType]) {
      if (!response.canRespond) {
        continue;
      }

      response._context = flowContext;
      response._map = this;

      List<FlowPage> prevPages = _routerDelegate.pages.toList();
      response.respond();

      MLog.log('${flowContext.runtimeType}');

      // Only fire updates after the very first context
      // has been fully responded to
      if (flowContext._isRoot) {
        if (!listEquals(prevPages, _routerDelegate.pages)) {
          _routerDelegate.setDirty(() {});
        } else {
          if (_routerDelegate.pages.length > 0) {
            MLog.log('Navigating to same page..', prepend: (FlowMap));
            Widget topPageChild = _routerDelegate.pages.last.child;
            if (topPageChild is FlowMapListenerMixin) {
              FlowMapListenerMixin listener =
                  topPageChild as FlowMapListenerMixin;
              listener.onNavigateSamePage();
            }
          }
        }
      }

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

abstract class FlowContext {
  bool _isRoot = true;
}

abstract class FlowResponse<T extends FlowContext> {
  Type get contextType => T;
  T get context => _context;
  T _context;

  List<FlowPage> get pages => _map._routerDelegate.pages;
  FlowMap _map;

  bool get canRespond => true;

  void navigate(FlowContext context) {
    context._isRoot = false;
    _map.navigate(context);
  }

  void respond();
}

mixin FlowMapListenerMixin {
  void onNavigateSamePage();
}
