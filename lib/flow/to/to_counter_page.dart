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
        child: CounterPage(
          key: GlobalKey<NavigatorState>(),
          title: Text('Counter'),
          bottomNavigationBarOnItemTap: (int index) =>
              navigate(ToHomeRoute(index)),
          bottomNavigationBarItems: BottomNavigationFactory.main(),
          onExtraTap: () => navigate(ToCounterPage()),
        )));
  }
}
