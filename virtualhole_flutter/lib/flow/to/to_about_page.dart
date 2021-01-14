import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import '../../virtualhole_client.dart';

class ToAboutPage extends FlowContext {}

class ToAboutPageResponse extends FlowResponse<ToAboutPage> {
  @override
  void respond() {
    pages.add(FlowPage(
        key: UniqueKey(),
        name: '/about',
        child: RootScaffold(
          key: GlobalKey<NavigatorState>(),
          body: AboutPage(),
          bottomNavigationBarItems: HomeBottomNavigationItemsBuilder().build(),
          bottomNavigationBarOnItemTap: (int index) =>
              navigate(FromHomeRoute(index)),
          bottomNavigationBarIndex: 3,
        )));
  }
}
