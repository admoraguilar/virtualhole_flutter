import 'package:flutter/material.dart';
import 'package:virtualhole_flutter/midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_flutter/client/config/config.dart' as config;
import 'package:virtualhole_flutter/client/pages/pages.dart';

class AppPage {
  AppPage();

  List<FlowAppPage> generateInitialPages() {
    return [_generateDiscoverPage()];
  }

  FlowAppPage _generateDiscoverPage() {
    return FlowAppPage(
      key: ValueKey('/discover'),
      name: '/discover',
      handlerSettingsBuilder: _generateHandlerSettings,
      scaffoldSettingsBuilder: (FlowAppState flowAppState) {
        return _generateScaffoldSettings(
          flowAppState,
          bottomNavigationBar: _generateBottomNavigationBar(
            flowAppState,
            currentIndex: 0,
          ),
        );
      },
      builder: (FlowAppState flowAppState) {
        print('build discover page');
        return DiscoverPage(
          key: UniqueKey(),
        );
      },
    );
  }

  FlowAppPage _generateSupportPage() {
    return FlowAppPage(
      key: ValueKey('/support'),
      name: '/support',
      handlerSettingsBuilder: _generateHandlerSettings,
      scaffoldSettingsBuilder: (FlowAppState flowAppState) {
        return _generateScaffoldSettings(
          flowAppState,
          bottomNavigationBar: _generateBottomNavigationBar(
            flowAppState,
            currentIndex: 3,
          ),
        );
      },
      builder: (_) {
        print('build support page');
        return SupportPage(
          key: UniqueKey(),
        );
      },
    );
  }

  FlowAppPage _generateTestPage() {
    return FlowAppPage(
      key: ValueKey('/test'),
      name: '/test',
      handlerSettingsBuilder: _generateHandlerSettings,
      scaffoldSettingsBuilder: (FlowAppState flowAppState) {
        return _generateScaffoldSettings(
          flowAppState,
          bottomNavigationBar: _generateBottomNavigationBar(
            flowAppState,
            currentIndex: 1,
          ),
        );
      },
      builder: (_) {
        print('build test page');
        return Center(
          child: Text('Hello!!'),
        );
      },
    );
  }

  FlowAppPage _generateCounterPage() {
    return FlowAppPage(
      key: ValueKey('/counter'),
      name: '/counter',
      handlerSettingsBuilder: _generateHandlerSettings,
      scaffoldSettingsBuilder: (FlowAppState flowAppState) {
        return _generateScaffoldSettings(
          flowAppState,
          bottomNavigationBar: _generateBottomNavigationBar(
            flowAppState,
            currentIndex: 1,
          ),
        );
      },
      builder: (FlowAppState flowAppState) {
        print('build counter page');
        return CounterScreen(
          key: GlobalKey<NavigatorState>(),
          onExtraTap: () {
            flowAppState.triggerSetState(
              () => flowAppState.pages.add(_generateCounterPage()),
            );
          },
        );
      },
    );
  }

  FlowAppPage _generateErrorPage() {
    return FlowAppPage(
      key: ValueKey('/error'),
      name: '/error',
      handlerSettingsBuilder: _generateHandlerSettings,
      scaffoldSettingsBuilder: (FlowAppState flowAppState) {
        return _generateScaffoldSettings(flowAppState);
      },
      builder: (_) {
        print('build error page');
        return Center(
          child: Text('404 ERROR!!'),
        );
      },
    );
  }

  FlowHandlerSettings _generateHandlerSettings(FlowAppState flowAppState) {
    assert(flowAppState != null);

    return FlowHandlerSettings(
      designType: FlowDesignType.Material,
      title: '${config.appName}',
      theme: ThemeData(
        primaryColor: Colors.blue[900],
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        ),
      ),
      onDeviceBackButtonPressed: flowAppState.handleBackButton,
    );
  }

  FlowScaffoldSettings _generateScaffoldSettings(
    FlowAppState flowAppState, {
    BottomNavigationBar bottomNavigationBar,
  }) {
    assert(flowAppState != null);

    return FlowScaffoldSettings(
      appBar: AppBar(
        title: Text('${config.appName}'),
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: flowAppState.handleBackButton,
            );
          },
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  Widget _generateBottomNavigationBar(
    FlowAppState flowAppState, {
    int currentIndex = 0,
  }) {
    assert(flowAppState != null);
    assert(currentIndex != null && currentIndex > -1);

    void pushPage(FlowAppPage flowAppPage) {
      flowAppState.triggerSetState(() => flowAppState.pages.add(flowAppPage));
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

              print(_counter);
            },
          ),
          FloatingActionButton(
            child: Icon(Icons.remove),
            onPressed: () {
              setState(() {
                _counter--;
              });
              print(_counter);
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
