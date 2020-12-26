import 'package:flutter/material.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_api_client_dart/virtualhole_api_client_dart.dart';
import '../configs/configs.dart';
import '../ui/ui.dart';
import '../pages/pages.dart';

class AppFlowPage {
  static List<FlowPage> generateInitialPages() {
    return [
      CreatorFlowPage(),
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

class AppContentFeedTab {
  static VirtualHoleApiClient _vHoleApi =
      VirtualHoleApiClient.managed(domain: AppConfig.virtualHoleApi);

  static ContentFeedTab generateDiscover() {
    return ContentFeedTab(
      name: 'Discover',
      builder: (int page) => APIResponseProvider(
        _vHoleApi.contents.getDiscover(ContentRequest(page: page)),
      ).getResult(),
    );
  }

  static ContentFeedTab generateCommunity() {
    return ContentFeedTab(
      name: 'Community',
      builder: (int page) => APIResponseProvider(
        _vHoleApi.contents.getCommunity(ContentRequest(page: page)),
      ).getResult(),
    );
  }

  static ContentFeedTab generateLive() {
    return ContentFeedTab(
      name: 'Live',
      builder: (int page) => APIResponseProvider(
        _vHoleApi.contents.getLive(ContentRequest(page: page)),
      ).getResult(),
    );
  }

  static ContentFeedTab generateScheduled() {
    return ContentFeedTab(
      name: 'Scheduled',
      builder: (int page) => APIResponseProvider(
        _vHoleApi.contents.getSchedule(ContentRequest(page: page)),
      ).getResult(),
    );
  }
}
