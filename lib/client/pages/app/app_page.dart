import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
      MaterialPage(
        key: ValueKey('discover_page'),
        child: DiscoverPage(),
      ),
    ];
  }

  List<Page<dynamic>> _pages;

  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
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
      onDeviceBackButtonPressed: _handleBackButton,
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
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Support',
          ),
        ],
      ),
    );
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
