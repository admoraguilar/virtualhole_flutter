import 'package:flutter/material.dart';
import 'package:virtualhole_flutter/midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_flutter/api/virtualhole_api_wrapper.dart';
import 'pages/pages.dart';

Future<void> main() async {
  print('Starting app...');

  VirtualHoleApiWrapperClient vHoleApi = VirtualHoleApiWrapperClient.managed(
    domain: 'https://virtualhole.app',
  );

  ViewModel.add(SupportListViewModel(
    resourcesClient: vHoleApi.resources,
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlowHandler();

    // PageNavigatorViewModel pageNavigatorViewModel =
    //     ViewModel.get<PageNavigatorViewModel>();

    // return MaterialApp(
    //   navigatorKey: pageNavigatorViewModel.root.key,
    //   title: 'holohole',
    //   theme: ThemeData(
    //     primaryColor: Colors.blue[900],
    //     visualDensity: VisualDensity.adaptivePlatformDensity,
    //     textTheme: TextTheme(
    //       headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    //       headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
    //     ),
    //   ),
    //   onGenerateInitialRoutes:
    //       pageNavigatorViewModel.root.generateInitialRoutes,
    //   onGenerateRoute: pageNavigatorViewModel.root.generateRoute,
    // );
  }
}
