import 'package:flutter/material.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import '../../virtualhole_client.dart';

class ToCounterPage extends FlowContext {}

class ToCounterPageResponse extends FlowResponse<ToCounterPage> {
  @override
  void respond() {
    pages.add(FlowPage(
        key: UniqueKey(),
        name: '/counter',
        child: RootScaffold(
          key: GlobalKey<NavigatorState>(),
          title: Text('Counter'),
          body: CounterPage(
            onExtraTap: () => navigate(ToCounterPage()),
          ),
          bottomNavigationBarItems: HomeBottomNavigationItemsBuilder().build(),
          bottomNavigationBarOnItemTap: (int index) =>
              navigate(FromHomeRoute(index)),
          bottomNavigationBarIndex: 1,
        )));
  }
}
