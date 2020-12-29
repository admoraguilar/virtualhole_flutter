import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import '../../virtualhole_client.dart';

class ToSupportPage extends FlowContext {}

class ToSupportPageResponse extends FlowResponse<ToSupportPage> {
  bool get canRespond => true;

  void respond() {
    MLog.log('support page respond');

    pages.add(FlowPage(
      key: UniqueKey(),
      name: '/support',
      child: SupportPage(
        key: GlobalKey<NavigatorState>(),
        onBottomNavigationBarItemTap: (int index) =>
            navigate(ToHomeRoute(index)),
        bottomNavigationBarItems: BottomNavigationFactory.main(),
      ),
    ));
  }
}
