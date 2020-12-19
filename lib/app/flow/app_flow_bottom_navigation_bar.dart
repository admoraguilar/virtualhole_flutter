import 'package:flutter/material.dart';
import 'package:virtualhole_flutter/app/app_flow.dart';
import 'package:virtualhole_flutter/midnight_flutter/midnight_flutter.dart';

class AppFlowBottomNavigationBar extends StatelessWidget {
  const AppFlowBottomNavigationBar({
    Key key,
    @required this.items,
    @required this.pages,
    @required this.currentIndex,
  })  : assert(items != null),
        assert(pages != null),
        assert(items.length == pages.length),
        assert(currentIndex != null && currentIndex > -1),
        super(key: key);

  final List<BottomNavigationBarItem> items;
  final List<FlowPage> pages;
  final currentIndex;

  @override
  Widget build(BuildContext context) {
    void pushPage(FlowPage flowAppPage) {
      FlowHandler.get().routerDelegate.setDirty(() {
        FlowHandler.get().routerDelegate.pages.add(flowAppPage);
      });
    }

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      items: items,
      onTap: (int index) => pushPage(pages[index]),
    );
  }
}
