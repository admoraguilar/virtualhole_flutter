import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:virtualhole_flutter/client/pages/counter/counter_page.dart';
import 'package:virtualhole_flutter/client/pages/pages.dart';
import 'package:virtualhole_flutter/midnight_flutter/midnight_flutter.dart';

class AppPage extends StatefulWidget {
  AppPage({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  _AppPageState() {
    _pages = [
      _buildCounterPage(),
    ];
  }

  List<Page<dynamic>> _pages;
  int _counter;

  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
      onDeviceBackButtonPressed: _handleBackButton,
      handlerSettings: FlowHandlerSettings(
        appType: FlowHandlerAppType.Material,
        title: widget.title,
        theme: ThemeData(
          primaryColor: Colors.blue[900],
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          ),
        ),
      ),
      pages: _pages,
      appBar: AppBar(
        title: Text('${widget.title}'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            _handleBackButton();
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.ac_unit),
            label: 'Temperatures',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Adjustments',
          ),
        ],
      ),
    );
  }

  Page _buildCounterPage() {
    Page makeCounterPage(VoidCallback onExtraTap) {
      return MaterialPage(
        key: ValueKey('counter_page$_counter'),
        child: CounterPage(
          key: GlobalKey<NavigatorState>(),
          onExtraTap: onExtraTap,
        ),
      );
    }

    void addCounterPage() {
      _pages.add(makeCounterPage(addCounterPage));
      setState(() {});
      print('page count: ${_pages.length}');
    }

    return makeCounterPage(addCounterPage);
  }

  Future<bool> _handleBackButton() {
    if (_pages.length > 1) {
      _pages.removeLast();
      setState(() {});
      print('page count: ${_pages.length}');
      return SynchronousFuture<bool>(true);
    }

    return SynchronousFuture<bool>(false);
  }
}
