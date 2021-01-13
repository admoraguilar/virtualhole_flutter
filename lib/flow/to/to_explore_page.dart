import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import '../../virtualhole_client.dart';

class ToExplorePage extends FlowContext {}

class ToExplorePageResponse extends FlowResponse<ToExplorePage> {
  @override
  void respond() {
    if (pages.length > 0 && pages.last.name == '/explore') {
      return;
    }

    pages.add(
      FlowPage(
        key: UniqueKey(),
        name: '/explore',
        child: Builder(
          builder: (BuildContext context) {
            return RootScaffold(
              key: GlobalKey<NavigatorState>(),
              body: ExplorePage(
                tabs: CreatorFeedTabBuilder().build(context),
                initialTabIndex: 0,
                onSetTab: (ContentFeedTab contentFeedTab) {
                  FirebaseAnalytics().logSelectContent(
                      contentType: 'explore.content_feed_tab',
                      itemId: contentFeedTab.name.toLowerCase());
                },
              ),
              bottomNavigationBarItems:
                  HomeBottomNavigationItemsBuilder().build(),
              bottomNavigationBarOnItemTap: (int index) =>
                  navigate(FromHomeRoute(index)),
              bottomNavigationBarIndex: 0,
            );
          },
        ),
      ),
    );
  }
}
