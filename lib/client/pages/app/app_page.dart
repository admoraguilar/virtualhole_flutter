import 'package:flutter/material.dart';
import 'package:virtualhole_flutter/midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_flutter/client/config/config.dart' as config;
import 'package:virtualhole_flutter/client/pages/pages.dart';

class AppPage {
  AppPage();

  List<FlowPage> generateInitialPages() {
    return [_generateDiscoverPage()];
  }

  FlowPage _generateDiscoverPage() {
    return FlowPage(
      key: UniqueKey(),
      name: '/discover',
      designType: FlowDesignType.Material,
      scaffoldSettings: _generateScaffoldSettings(
        bottomNavigationBar: _generateBottomNavigationBar(
          currentIndex: 0,
        ),
      ),
      child: DiscoverPage(
        key: GlobalKey<NavigatorState>(),
      ),
    );
  }

  FlowPage _generateSupportPage() {
    return FlowPage(
      key: UniqueKey(),
      name: '/support',
      designType: FlowDesignType.Material,
      scaffoldSettings: _generateScaffoldSettings(
        bottomNavigationBar: _generateBottomNavigationBar(
          currentIndex: 3,
        ),
      ),
      child: SupportPage(
        key: GlobalKey<NavigatorState>(),
      ),
    );
  }

  FlowPage _generateTestPage() {
    return FlowPage(
      key: UniqueKey(),
      name: '/test',
      designType: FlowDesignType.Material,
      scaffoldSettings: _generateScaffoldSettings(
        bottomNavigationBar: _generateBottomNavigationBar(
          currentIndex: 1,
        ),
      ),
      child: Center(
        child: Text('Hello!!'),
      ),
    );
  }

  FlowPage _generateCounterPage() {
    return FlowPage(
      key: UniqueKey(),
      name: '/counter',
      designType: FlowDesignType.Material,
      scaffoldSettings: _generateScaffoldSettings(
        bottomNavigationBar: _generateBottomNavigationBar(currentIndex: 1),
      ),
      child: CounterScreen(
        key: GlobalKey<NavigatorState>(),
        onExtraTap: () {
          FlowHandler.instance()
              .routerDelegate
              .pages
              .add(_generateCounterPage());
          FlowHandler.instance().routerDelegate.triggerNotifyListeners();
        },
      ),
    );
  }

  FlowPage _generateErrorPage() {
    return FlowPage(
      key: UniqueKey(),
      name: '/error',
      designType: FlowDesignType.Material,
      scaffoldSettings: _generateScaffoldSettings(),
      child: Center(
        key: GlobalKey<NavigatorState>(),
        child: Text('404 ERROR!!'),
      ),
    );
  }

  FlowScaffoldSettings _generateScaffoldSettings(
      {BottomNavigationBar bottomNavigationBar}) {
    return FlowScaffoldSettings(
      appBar: AppBar(
        title: Text('${config.appName}'),
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: FlowHandler.instance().routerDelegate.popRoute,
            );
          },
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  Widget _generateBottomNavigationBar({int currentIndex = 0}) {
    assert(currentIndex != null && currentIndex > -1);

    void pushPage(FlowPage flowAppPage) {
      FlowHandler.instance().routerDelegate.pages.add(flowAppPage);
      FlowHandler.instance().routerDelegate.triggerNotifyListeners();
    }

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
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
      onTap: (int index) {
        if (index == 0) {
          pushPage(_generateDiscoverPage());
        } else if (index == 1) {
          pushPage(_generateCounterPage());
        } else if (index == 2) {
          pushPage(_generateErrorPage());
        } else if (index == 3) {
          pushPage(_generateSupportPage());
        }
      },
    );
  }
}

class CounterScreen extends StatefulWidget {
  CounterScreen({
    Key key,
    this.onExtraTap,
  }) : super(key: key);

  final VoidCallback onExtraTap;

  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Count: $_counter'),
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              setState(() {
                _counter++;
              });
              // print(_counter);
            },
          ),
          FloatingActionButton(
            child: Icon(Icons.remove),
            onPressed: () {
              setState(() {
                _counter--;
              });
              // print(_counter);
            },
          ),
          FloatingActionButton(
            child: Icon(Icons.settings),
            onPressed: widget.onExtraTap,
          ),
        ],
      ),
    );
  }
}
