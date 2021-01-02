import 'package:VirtualHole/ui/elements/root_scaffold.dart';
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
      child: RootScaffold(
        key: GlobalKey<NavigatorState>(),
        body: ExplorePage(
          tabs: ExploreFeedTabBuilder().build(),
          initialTabIndex: 0,
        ),
        bottomNavigationBarItems: HomeBottomNavigationItemsBuilder().build(),
        bottomNavigationBarOnItemTap: (int index) =>
            navigate(FromHomeRoute(index)),
        bottomNavigationBarIndex: 0,
      ),
    ));
  }
}
