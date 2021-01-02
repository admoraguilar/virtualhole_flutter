import 'package:flutter/material.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import 'virtualhole_client.dart';

class RootSetup extends StatelessWidget {
  const RootSetup({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocalStorageClient().init();

    return FlowApp(
      initialContext: ToExplorePage(),
      map: FlowMap([
        FromHomeRouteResponse(),
        ToExplorePageResponse(),
        ToCounterPageResponse(),
        ToSupportPageResponse(),
        ToErrorPageResponse(),
        ToCreatorPageResponse(),
        ToSearchPageResponse(),
        FromContentCardResponse(),
      ]),
      title: AppConfig().appName,
      theme: ThemeData(
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
      ),
      debugShowCheckedModeBanner: false,
    );

    // return MaterialApp(
    //   home: SearchPage(),
    //   title: 'holohole',
    //   theme: ThemeData(
    //     brightness: Brightness.dark,
    //     primaryColor: Colors.lightBlue[700],
    //     accentColor: Colors.lightBlue[700],
    //     backgroundColor: Colors.black,
    //     visualDensity: VisualDensity.adaptivePlatformDensity,
    //     textTheme: TextTheme(
    //       headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    //       headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
    //     ),
    //     scaffoldBackgroundColor: Colors.black,
    //     bottomNavigationBarTheme: BottomNavigationBarThemeData(
    //       backgroundColor: Colors.black,
    //     ),
    //   ),
    //   debugShowCheckedModeBanner: false,
    // );
  }
}
