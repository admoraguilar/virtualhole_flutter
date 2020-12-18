import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:virtualhole_flutter/midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_flutter/client/config/config.dart' as config;
import 'pages.dart';

FlowAppPage createDiscoverPage() {
  return FlowAppPage(
    key: ValueKey('/discover'),
    name: '/discover',
    handlerSettingsBuilder: (FlowAppState flowAppState) {
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
    },
    scaffoldSettingsBuilder: (FlowAppState flowAppState) {
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
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: 0,
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
            if (index == 1) {
              flowAppState.triggerSetState(
                () => flowAppState.pages.add(createTestPage()),
              );
            } else if (index == 2) {
              flowAppState.triggerSetState(
                () => flowAppState.pages.add(createErrorPage()),
              );
            } else if (index == 3) {
              flowAppState.triggerSetState(
                () => flowAppState.pages.add(createSupportPage()),
              );
            }
          },
        ),
      );
    },
    builder: (FlowAppState flowAppState) {
      return DiscoverPage();
    },
  );
}

FlowAppPage createSupportPage() {
  return FlowAppPage(
    key: ValueKey('/support'),
    name: '/support',
    handlerSettingsBuilder: (FlowAppState flowAppState) {
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
    },
    scaffoldSettingsBuilder: (FlowAppState flowAppState) {
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
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: 3,
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
            if (index == 1) {
              flowAppState.triggerSetState(
                () => flowAppState.pages.add(
                  createTestPage(),
                ),
              );
            } else if (index == 2) {
              flowAppState.triggerSetState(
                () => flowAppState.pages.add(
                  createErrorPage(),
                ),
              );
            }
          },
        ),
      );
    },
    builder: (FlowAppState flowAppState) {
      return SupportPage();
    },
  );
}

FlowAppPage createTestPage() {
  return FlowAppPage(
    key: ValueKey('/test'),
    name: '/test',
    handlerSettingsBuilder: (FlowAppState flowAppState) {
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
    },
    scaffoldSettingsBuilder: (FlowAppState flowAppState) {
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
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: 1,
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
          onTap: (int index) {},
        ),
      );
    },
    builder: (FlowAppState flowAppState) {
      return Center(
        child: Text('Hello!!'),
      );
    },
  );
}

FlowAppPage createErrorPage() {
  return FlowAppPage(
    key: ValueKey('/error'),
    name: '/error',
    handlerSettingsBuilder: (FlowAppState flowAppState) {
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
    },
    scaffoldSettingsBuilder: (FlowAppState flowAppState) {
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
      );
    },
    builder: (FlowAppState flowAppState) {
      return Center(
        child: Text('404 Error!!'),
      );
    },
  );
}
