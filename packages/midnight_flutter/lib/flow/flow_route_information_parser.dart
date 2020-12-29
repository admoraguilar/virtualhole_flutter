import 'package:flutter/material.dart';
import '../midnight_flutter.dart';

class FlowRouteInformationParser extends RouteInformationParser<FlowRoutePath> {
  @override
  Future<FlowRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    // This doesn't handle web at the moment
    return FlowRoutePath(location: routeInformation.location);
  }

  @override
  RouteInformation restoreRouteInformation(FlowRoutePath configuration) {
    return RouteInformation(location: configuration.location);
  }
}
