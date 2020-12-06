import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:virtualhole_flutter/api/storage/storage_client.dart';
import 'package:virtualhole_flutter/client/viewmodels/support_list_viewmodel.dart';
import 'package:virtualhole_flutter/common/common.dart';
import 'package:virtualhole_flutter/api/virtualhole_api_wrapper.dart';
import 'widgets/widgets.dart';
import 'viewmodels/viewmodels.dart';
import 'controllers/controllers.dart';

Future<void> main() async {
  // print('Starting app...');

  // http.Response res = await http.post(
  //   'https://virtualhole.app/api/Creators/ListCreatorsStrict',
  //   headers: <String, String>{'Content-Type': 'application/json'},
  //   body: '{ "isAll": true }',
  // );
  // print(res.body);

  // DynamicClient dynamicClient =
  //     DynamicClient(domain: 'https://virtualhole.b-cdn.net');
  // List<SupportInfo> supportInfo = await dynamicClient.listSupportInfoAsync();
  // supportInfo.forEach((element) {
  //   String e = element.toString();
  //   print(e);
  // });

  // String data = '{ "firstName": "Bob", "lastName": "McCollins" }';
  // dynamic jObj = json.decode(data);
  // print(jObj['firstName']);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ViewModelContainer.instance.add(CounterViewModel());
    ViewModelContainer.instance.add(SupportListViewModel(
      storageClient: StorageClient(
        domain: 'https://virtualhole.b-cdn.net/',
      ),
    ));

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
