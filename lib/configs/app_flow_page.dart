import 'package:flutter/material.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import '../pages/pages.dart';

class RootFlowPageHelper {
  static List<FlowPage> generateInitialPages() {
    return [
      HomeFlowPage(),
    ];
  }

  static FlowPage generateRootPages(int index) {
    if (index == 0)
      return HomeFlowPage();
    else if (index == 1)
      return CounterFlowPage();
    else if (index == 2)
      return ErrorFlowPage();
    else if (index == 3)
      return SupportFlowPage();
    else
      return ErrorFlowPage();
  }

  static List<BottomNavigationBarItem> generateBottomNavigationBarItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.explore),
        label: 'Explore',
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
