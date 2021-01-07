import 'package:flutter/material.dart';
import '../../../virtualhole_client.dart';

class HomeBottomNavigationItemsBuilder extends BottomNavigationItemsFactory {
  @override
  List<BottomNavigationBarItem> build() {
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
        icon: Icon(Icons.info),
        label: 'About',
      ),
    ];
  }
}
