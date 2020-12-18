import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:virtualhole_flutter/midnight_flutter/midnight_flutter.dart';
import 'pages.dart';

FlowPage createDiscoverPage() {
  return FlowPage(
    designType: FlowDesignType.Material,
    index: 3,
    child: DiscoverPage(),
    key: ValueKey('/discover'),
    name: '/discover',
  );
}

FlowPage createTestPage() {
  return FlowPage(
    designType: FlowDesignType.Material,
    index: 1,
    child: Center(
      child: Text('Hello!!'),
    ),
    key: ValueKey('/discover'),
    name: '/discover',
  );
}

FlowPage createErrorPage() {
  return FlowPage(
    designType: FlowDesignType.Material,
    child: Center(
      child: Text('404 Error!'),
    ),
    key: ValueKey('/error'),
    name: '/error',
  );
}
