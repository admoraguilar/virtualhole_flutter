import 'package:flutter/material.dart';
import 'package:midnight_flutter/midnight_flutter.dart';

class RootScaffold extends StatelessWidget {
  static int _bottomNavigationBarIndex = 0;

  const RootScaffold({
    Key key,
    this.bottomNavigationBarIndex,
    @required this.title,
    @required this.body,
    @required this.pageBuilder,
    @required this.bottomNavigationBarItems,
  })  : assert(body != null),
        assert(pageBuilder != null),
        assert(bottomNavigationBarItems != null),
        super(key: key);

  final String title;
  final Widget body;
  final List<FlowPage> Function() pageBuilder;
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

    return Scaffold(
      body: body,
      appBar: AppBar(
        // title: Text('$title'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: FlowHandler.get().routerDelegate.popRoute,
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: bottomNavigationBarItems,
        onTap: (int index) {
          List<FlowPage> pages = pageBuilder();
          assert(pages.length == bottomNavigationBarItems.length);

          FlowHandler.get().routerDelegate.setDirty(() {
            FlowHandler.get().routerDelegate.pages.add(pages[index]);
          });
        },
        currentIndex: _bottomNavigationBarIndex,
      ),
      extendBodyBehindAppBar: true,
    );
  }
}
