import 'package:flutter/material.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
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
        body: SearchPage(),
        bottomNavigationBarItems: HomeBottomNavigationItemsBuilder().build(),
        bottomNavigationBarOnItemTap: (int index) =>
            navigate(FromHomeRoute(index)),
        bottomNavigationBarIndex: 2,
      ),
    ));
  }
}
