import 'package:flutter/material.dart';
import 'flow_handler.dart';

class FlowHandlerRouteInformationParser
    extends RouteInformationParser<FlowHandlerRoutePath> {
  @override
  Future<FlowHandlerRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    // This doesn't handle web at the moment
    return FlowHandlerRoutePath(location: routeInformation.location);
  }

  @override
  RouteInformation restoreRouteInformation(FlowHandlerRoutePath configuration) {
    return RouteInformation(location: configuration.location);
  }
}
