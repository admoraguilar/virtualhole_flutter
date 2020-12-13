import 'package:flutter/material.dart';
import 'package:virtualhole_flutter/common/common.dart';
import 'package:virtualhole_flutter/api/virtualhole_api_wrapper.dart';
import 'viewmodels/viewmodels.dart';
import 'controllers/controllers.dart';
import 'widgets/widgets.dart';

Future<void> main() async {
  print('Starting app...');

  VirtualHoleApiWrapperClient vHoleApi = VirtualHoleApiWrapperClient.managed(
    domain: 'https://virtualhole.app',
  );

  ViewModelContainer.instance.add(CounterViewModel());
  ViewModelContainer.instance.add(SupportListViewModel(
    resourcesClient: vHoleApi.resources,
  ));

  // ignore: unused_local_variable
  CounterController counterController = CounterController();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'holohole',
      theme: ThemeData(
        primaryColor: Colors.blue[900],
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        ),
      ),
      home: HomePage(
        title: 'holohole',
      ),
    );
  }
}
