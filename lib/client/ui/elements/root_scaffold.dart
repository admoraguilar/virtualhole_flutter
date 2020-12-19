import 'package:flutter/material.dart';
import 'package:virtualhole_flutter/midnight_flutter/midnight_flutter.dart';

class RootScaffold extends StatelessWidget {
  const RootScaffold({
    Key key,
    @required this.title,
    @required this.body,
    @required this.pages,
    @required this.bottomNavigationBarItems,
  })  : assert(body != null),
        assert(pages != null),
        assert(bottomNavigationBarItems != null),
        assert(pages.length == bottomNavigationBarItems.length),
        super(key: key);

  final String title;
  final Widget body;
  final List<FlowPage> pages;
  final List<BottomNavigationBarItem> bottomNavigationBarItems;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      appBar: AppBar(
        title: Text('$title'),
        automaticallyImplyLeading: false,
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
          FlowHandler.get().routerDelegate.setDirty(() {
            FlowHandler.get().routerDelegate.pages.add(pages[index]);
          });
        },
      ),
    );
  }
}
