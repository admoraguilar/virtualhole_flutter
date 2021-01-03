import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_api_client_dart/virtualhole_api_client_dart.dart';
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
          onTapCard: (ContentDTO contentDTO) {
            FirebaseAnalytics().logViewItem(
              itemId: contentDTO.content.id,
              itemName: contentDTO.content.title,
              itemCategory: contentDTO.content.fullType,
            );
          },
          onTapMore: (ContentDTO contentDTO) {
            FirebaseAnalytics().logViewItem(
              itemId: contentDTO.content.id,
              itemName: contentDTO.content.title,
              itemCategory: contentDTO.content.fullType,
            );

            FirebaseAnalytics().logViewItem(
              itemId: contentDTO.content.creator.id,
              itemName: contentDTO.content.creator.name,
              itemCategory: 'creator',
            );
          },
          onSetTab: (ContentFeedTab contentFeedTab) {
            FirebaseAnalytics().logSelectContent(
                contentType: 'followed.content_feed_tab',
                itemId: contentFeedTab.name.toLowerCase());
          },
        ),
        bottomNavigationBarItems: HomeBottomNavigationItemsBuilder().build(),
        bottomNavigationBarOnItemTap: (int index) =>
            navigate(FromHomeRoute(index)),
        bottomNavigationBarIndex: 1,
      ),
    ));
  }
}