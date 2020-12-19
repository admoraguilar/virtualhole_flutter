import 'package:flutter/material.dart';
import 'package:virtualhole_flutter/midnight_flutter/midnight_flutter.dart';

class ErrorFlowPage<T> extends FlowPage<T> {
  ErrorFlowPage()
      : super(
          key: UniqueKey(),
          name: '/error',
          designType: FlowDesignType.Material,
          child: Center(
            key: GlobalKey<NavigatorState>(),
            child: Text('404 ERROR!!'),
          ),
        );
}
