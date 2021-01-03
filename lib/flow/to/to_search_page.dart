import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_api_client_dart/virtualhole_api_client_dart.dart';
import '../../virtualhole_client.dart';

class ToSearchPage extends FlowContext {}

class ToSearchPageResponse extends FlowResponse<ToSearchPage> {
  @override
  void respond() {
    pages.add(FlowPage(
      key: UniqueKey(),
      name: '/search',
      child: RootScaffold(
        key: GlobalKey<NavigatorState>(),
        isShowAppBar: false,
        body: SearchPage(
          onSearchInitiate: (String search) {
            FirebaseAnalytics().logSearch(searchTerm: search);
          },
          onCreatorTap: (Creator creator, String search) {
            FirebaseAnalytics().logViewItem(
              searchTerm: search,
              itemId: creator.id,
              itemName: creator.name,
              itemCategory: 'creator',
            );
          },
        ),
        bottomNavigationBarItems: HomeBottomNavigationItemsBuilder().build(),
        bottomNavigationBarOnItemTap: (int index) =>
            navigate(FromHomeRoute(index)),
        bottomNavigationBarIndex: 2,
      ),
    ));
  }
}
