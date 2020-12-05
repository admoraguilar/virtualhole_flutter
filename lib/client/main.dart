import 'package:flutter/material.dart';
import 'package:virtualhole_flutter/common/common.dart';
import 'views/views.dart';
import 'viewmodels/viewmodels.dart';
import 'controllers/controllers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ViewModelContainer.instance.add(CounterViewModel());

    // ignore: unused_local_variable
    CounterController counterController = CounterController();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(
        title: 'Flutter Demo Home Page',
      ),
    );
  }
}
