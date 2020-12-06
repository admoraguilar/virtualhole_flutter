import 'package:flutter/material.dart';
import 'package:virtualhole_flutter/common/common.dart';
import 'widgets/widgets.dart';
import 'viewmodels/viewmodels.dart';
import 'controllers/controllers.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  // print('Starting app...');

  // http.Response res = await http.post(
  //   'https://virtualhole.app/api/Creators/ListCreatorsStrict',
  //   headers: <String, String>{'Content-Type': 'application/json'},
  //   body: '{ "isAll": true }',
  // );

  // print(res.body);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ViewModelContainer.instance.add(CounterViewModel());

    // ignore: unused_local_variable
    CounterController counterController = CounterController();

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
