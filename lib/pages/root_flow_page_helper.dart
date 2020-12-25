import 'package:flutter/material.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import 'pages.dart';

class RootFlowPageHelper {
  static List<FlowPage> generateInitialPages() {
    return [
      CreatorFlowPage(),
    ];
  }

  static List<FlowPage> generateRootPages() {
    return [
      HomeFlowPage(),
      CounterFlowPage(),
      ErrorFlowPage(),
      SupportFlowPage(),
    ];
  }

  static List<BottomNavigationBarItem> generateBottomNavigationBarItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.explore),
        label: 'Discover',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.list),
        label: 'Feed',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: 'Search',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        label: 'Support',
      ),
    ];
  }
}
