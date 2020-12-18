import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:virtualhole_flutter/midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_flutter/api/virtualhole_api_wrapper.dart';
import 'package:virtualhole_flutter/client/config/config.dart' as config;
import 'package:virtualhole_flutter/client/pages/pages.dart';

class AppPage extends StatefulWidget {
  AppPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  _AppPageState() {
    VirtualHoleApiWrapperClient vHoleApi =
        VirtualHoleApiWrapperClient.managed(domain: config.virtualHoleApi);

    ViewModel.add(SupportListViewModel(resourcesClient: vHoleApi.resources));

    _title = config.appName;

    _pages = [
      createDiscoverPage(),
      createTestPage(),
    ];
  }

  String _title;
  List<FlowPage> _pages;

  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
      handlerSettings: FlowHandlerSettings(
        designType: FlowDesignType.Material,
        title: _title,
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
        title: Text('$_title'),
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
        currentIndex: getTopFlowPageIndex(),
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

  int getTopFlowPageIndex() {
    int index = _pages.lastIndexWhere((element) => element.index != null);
    FlowPage flowPage = index > -1 ? _pages[index] : null;
    return flowPage != null ? flowPage.index : 0;
  }
}
