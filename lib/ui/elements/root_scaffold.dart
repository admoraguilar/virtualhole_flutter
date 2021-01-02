import 'package:flutter/material.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import '../../virtualhole_client.dart';

class RootScaffold extends StatefulWidget {
  RootScaffold({
    Key key,
    this.title,
    this.appBar,
    @required this.body,
    this.bottomNavigationBarItems,
    this.bottomNavigationBarOnItemTap,
    this.bottomNavigationBarIndex,
  })  : assert(body != null),
        super(key: key);

  final Widget title;
  final PreferredSize appBar;
  final Widget body;
  final Function(int index) bottomNavigationBarOnItemTap;
  final List<BottomNavigationBarItem> bottomNavigationBarItems;
  final int bottomNavigationBarIndex;

  @override
  _RootScaffoldState createState() => _RootScaffoldState();
}

class _RootScaffoldState extends State<RootScaffold> {
  static int _bottomNavigationBarIndex = 0;

  AppBar _appBar;
  BottomNavigationBar _bottomNavigationBar;

  @override
  void initState() {
    super.initState();

    if (widget.appBar != null) {
      _appBar = AppBar(
        title: widget.title,
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
      );
    }

    _updateBottomNavigationBarIndex();

    if (widget.bottomNavigationBarItems != null &&
        widget.bottomNavigationBarOnItemTap != null) {
      _bottomNavigationBar = BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: widget.bottomNavigationBarItems,
        onTap: widget.bottomNavigationBarOnItemTap,
        currentIndex: _bottomNavigationBarIndex,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _updateBottomNavigationBarIndex();

    return SafeArea(
      child: Scaffold(
        appBar: _appBar,
        body: NetworkResilientWidget(
          networkChecking: HololiveRotatingImage(),
          networkError: ErrorPage(),
          child: widget.body,
        ),
        bottomNavigationBar: _bottomNavigationBar,
        extendBodyBehindAppBar: true,
      ),
    );
  }

  void _updateBottomNavigationBarIndex() {
    if (widget.bottomNavigationBarIndex != null) {
      _bottomNavigationBarIndex = widget.bottomNavigationBarIndex;
      _bottomNavigationBarIndex =
          _bottomNavigationBarIndex >= widget.bottomNavigationBarItems.length
              ? 0
              : _bottomNavigationBarIndex;
    }

    MLog.log('Index: $_bottomNavigationBarIndex');
  }
}
