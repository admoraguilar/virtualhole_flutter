import 'package:flutter/material.dart';

class FlowPage<T> extends Page<T> {
  FlowPage({
    @required this.child,
    LocalKey key,
    String name,
    Object arguments,
  })  : assert(child != null),
        super(
          key: key,
          name: name,
          arguments: arguments,
        );

  final Widget child;

  @override
  Route<T> createRoute(BuildContext context) {
    return MaterialPage(
      key: key,
      name: name,
      arguments: arguments,
      child: child,
    ).createRoute(context);
  }
}
