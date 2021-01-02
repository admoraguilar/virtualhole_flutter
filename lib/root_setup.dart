import 'package:flutter/material.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import 'virtualhole_client.dart';

class RootSetup extends StatefulWidget {
  const RootSetup({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RootSetupState();
}

class _RootSetupState extends State<RootSetup> {
  Future<List<Future>> _initSystemsFuture;

  @override
  void initState() {
    super.initState();

    Midnight.init();
    _initSystemsFuture = Future.wait([
      LocalStorageClient().init(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // Initialize systems here...
    return FutureBuilder(
      future: _initSystemsFuture,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _createMaterialAppWrapper(Align(
            alignment: Alignment.center,
            child: HololiveRotatingImage(),
          ));
        }

        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasError) {
          print(snapshot.error);
          return _createMaterialAppWrapper(Align(
            alignment: Alignment.center,
            child: ErrorPage(),
          ));
        }

        return FlowApp(
          initialContext: ToFollowedPage(),
          map: FlowMap([
            FromHomeRouteResponse(),
            ToExplorePageResponse(),
            ToFollowPageResponse(),
            ToSupportPageResponse(),
            ToErrorPageResponse(),
            ToCreatorPageResponse(),
            ToSearchPageResponse(),
            FromContentCardResponse(),
          ]),
          title: AppConfig().appName,
          theme: _createRootTheme(),
          debugShowCheckedModeBanner: false,
        );
      },
    );

    // return _createMaterialAppWrapper(SearchPage());
  }

  Widget _createMaterialAppWrapper(Widget home) {
    return MaterialApp(
      title: AppConfig().appName,
      home: home,
      theme: _createRootTheme(),
      debugShowCheckedModeBanner: false,
    );
  }

  ThemeData _createRootTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.lightBlue[700],
      accentColor: Colors.lightBlue[700],
      backgroundColor: Colors.black,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: TextTheme(
        headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      ),
      scaffoldBackgroundColor: Colors.black,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.black,
      ),
    );
  }
}
