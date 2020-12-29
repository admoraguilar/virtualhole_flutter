import 'package:flutter/material.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import '../../virtualhole_client.dart';

class ToExplorePage extends FlowContext {}

class ToExplorePageResponse extends FlowResponse<ToExplorePage> {
  bool get canRespond => true;

  void respond() {
    if (pages.length > 0 && pages.last.name == '/explore') {
      return;
    }

    pages.add(FlowPage(
      key: UniqueKey(),
      name: '/explore',
      child: ExplorePage(
        key: GlobalKey<NavigatorState>(),
        contentFeedTabs: ContentFeedTabFactory.main(),
        onBottomNavigationBarItemTap: (int index) =>
            navigate(ToHomeRoute(index)),
        bottomNavigationBarItems: BottomNavigationFactory.main(),
        contentFeedInitialTabIndex: 0,
      ),
    ));
  }
}
