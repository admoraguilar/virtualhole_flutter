import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import '../../virtualhole_client.dart';

class ToSupportPage extends FlowContext {}

class ToSupportPageResponse extends FlowResponse<ToSupportPage> {
  @override
  void respond() {
    pages.add(FlowPage(
      key: UniqueKey(),
      name: '/support',
      child: SupportPage(
        key: GlobalKey<NavigatorState>(),
        bottomNavigationBarOnItemTap: (int index) =>
            navigate(FromHomeRoute(index)),
        bottomNavigationBarItems: BottomNavigationFactory.main(),
      ),
    ));
  }
}
