import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'flow_handler.dart';

class FlowPage<T> extends Page<T> {
  FlowPage({
    @required this.designType,
    @required this.child,
    LocalKey key,
    String name,
    Object arguments,
  })  : assert(designType != null),
        assert(child != null),
        super(
          key: key,
          name: name,
          arguments: arguments,
        );

  final FlowDesignType designType;
  final Widget child;

  @override
  Route<T> createRoute(BuildContext context) {
    if (designType == FlowDesignType.Material) {
      return MaterialPage(
        key: key,
        name: name,
        arguments: arguments,
        child: child,
      ).createRoute(context);
    } else if (designType == FlowDesignType.Cupertino) {
      return CupertinoPage(
        key: key,
        title: name,
        name: name,
        arguments: arguments,
        child: child,
      ).createRoute(context);
    }

    throw Exception(
        '[${(FlowHandler).toString()}] Unsupported flow design type.');
  }
}
