import 'package:flutter/material.dart';
import 'package:midnight_flutter/midnight_flutter.dart';

class FlowScaffold extends StatelessWidget {
  static int _bottomNavigationBarIndex = 0;

  const FlowScaffold({
    Key key,
    this.title,
    @required this.body,
    this.bottomNavigationBarItems,
    this.onBottomNavigationBarItemTap,
    this.bottomNavigationBarIndex = 0,
  })  : assert(body != null),
        super(key: key);

  final Widget title;
  final Widget body;
  final Function(int index) onBottomNavigationBarItemTap;
  final List<BottomNavigationBarItem> bottomNavigationBarItems;
  final int bottomNavigationBarIndex;

  @override
  Widget build(BuildContext context) {
    if (bottomNavigationBarIndex != null) {
      _bottomNavigationBarIndex =
          bottomNavigationBarIndex >= bottomNavigationBarItems.length
              ? 0
              : bottomNavigationBarIndex;
    }

    BottomNavigationBar bottomNavigationBar;
    if (bottomNavigationBarItems != null &&
        onBottomNavigationBarItemTap != null) {
      bottomNavigationBar = BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: bottomNavigationBarItems,
        onTap: onBottomNavigationBarItemTap,
        currentIndex: _bottomNavigationBarIndex,
      );
    }

    return Scaffold(
      body: body,
      appBar: AppBar(
        title: title,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: FlowApp.of(context).routerDelegate.popRoute,
            );
          },
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
      extendBodyBehindAppBar: true,
    );
  }
}
