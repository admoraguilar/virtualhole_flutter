import 'package:flutter/material.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import '../../virtualhole_client.dart';

class ToExplorePage extends FlowContext {}

class ToExplorePageResponse extends FlowResponse<ToExplorePage> {
  @override
  void respond() {
    if (pages.length > 0 && pages.last.name == '/explore') {
      return;
    }

    pages.add(FlowPage(
      key: UniqueKey(),
      name: '/explore',
      child: ExplorePage(
        key: GlobalKey<NavigatorState>(),
        tabs: ContentFeedTabFactory.main(),
        bottomNavigationBarOnItemTap: (int index) =>
            navigate(FromHomeRoute(index)),
        bottomNavigationBarItems: BottomNavigationFactory.main(),
        initialTabIndex: 0,
      ),
    ));
  }
}
