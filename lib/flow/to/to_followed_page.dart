import 'package:flutter/material.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import '../../virtualhole_client.dart';

class ToFollowedPage extends FlowContext {}

class ToFollowPageResponse extends FlowResponse<ToFollowedPage> {
  @override
  void respond() {
    if (pages.length > 0 && pages.last.name == '/followed') {
      return;
    }

    LocalStorageClient localStorage = LocalStorageClient();

    pages.add(FlowPage(
      key: UniqueKey(),
      name: '/followed',
      child: RootScaffold(
        key: GlobalKey<NavigatorState>(),
        body: ExplorePage(
          tabs: CreatorFeedTabBuilder.fromIds(
            localStorage.userData.followedCreatorIds,
          ).build(),
          initialTabIndex: 0,
        ),
        bottomNavigationBarItems: HomeBottomNavigationItemsBuilder().build(),
        bottomNavigationBarOnItemTap: (int index) =>
            navigate(FromHomeRoute(index)),
        bottomNavigationBarIndex: 1,
      ),
    ));
  }
}
