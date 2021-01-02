import 'package:flutter/material.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import 'virtualhole_client.dart';

class RootSetup extends StatelessWidget {
  const RootSetup({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _materialAppWrapper(Widget home) {
      return MaterialApp(
        home: home,
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
    }

    return FutureBuilder(
      future: Future.wait([
        LocalStorageClient().init(),
      ]),
      builder: (BuildContext context, AsyncSnapshot<List<void>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _materialAppWrapper(Align(
            alignment: Alignment.center,
            child: HololiveRotatingImage(),
          ));
        }

        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasError) {
          print(snapshot.error);
          return _materialAppWrapper(Align(
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
      },
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
