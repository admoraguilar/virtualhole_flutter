import 'package:flutter/material.dart';
import 'package:midnight_flutter/midnight_flutter.dart';

class RootScaffold extends StatelessWidget {
  static int _bottomNavigationBarIndex = 0;

  const RootScaffold({
    Key key,
    this.title,
    @required this.body,
    @required this.pageBuilder,
    @required this.bottomNavigationBarItems,
    this.bottomNavigationBarIndex = 0,
    this.onBottomNavigateSamePage,
  })  : assert(body != null),
        assert(pageBuilder != null),
        assert(bottomNavigationBarItems != null),
        assert(bottomNavigationBarIndex != null &&
            bottomNavigationBarIndex < bottomNavigationBarItems.length),
        super(key: key);

  final Widget title;
  final Widget body;
  final FlowPage Function(int index) pageBuilder;
  final Function() onBottomNavigateSamePage;
  final List<BottomNavigationBarItem> bottomNavigationBarItems;
  final int bottomNavigationBarIndex;

  @override
  Widget build(BuildContext context) {
    _bottomNavigationBarIndex =
        bottomNavigationBarIndex >= bottomNavigationBarItems.length
            ? 0
            : bottomNavigationBarIndex;

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
              onPressed: FlowHandler.get().routerDelegate.popRoute,
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: bottomNavigationBarItems,
        onTap: (int index) {
          // TODO: Handle cases where there are same page underneath the
          // stack
          FlowPage page = pageBuilder(index);
          FlowPage currentPage = FlowHandler.get().routerDelegate.pages.last;

          if (currentPage.runtimeType == page.runtimeType &&
              currentPage.child.runtimeType == page.child.runtimeType) {
            MLog.log(
              'Navigating to same page',
              prepend: (RootScaffold),
            );
            onBottomNavigateSamePage?.call();
            return;
          }

          if (page != null) {
            FlowHandler.get().routerDelegate.setDirty(() {
              FlowHandler.get().routerDelegate.pages.add(page);
            });
          }
        },
        currentIndex: _bottomNavigationBarIndex,
      ),
      extendBodyBehindAppBar: true,
    );
  }
}
