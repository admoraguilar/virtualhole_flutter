import 'package:flutter/material.dart';
import 'package:virtualhole_flutter/client/viewmodels/viewmodels.dart';
import 'package:virtualhole_flutter/common/common.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key, this.title, CounterViewModel counterViewModel})
      : counterViewModel = counterViewModel ??
            ViewModelContainer.instance.get<CounterViewModel>(),
        super(key: key);

  final String title;
  final CounterViewModel counterViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            ViewModelAdapter(
              observables: (context, container) {
                return [counterViewModel.counter];
              },
              builder: (context, container) {
                Navigator.of(context).pop();
                return Text(
                  '${counterViewModel.counter.value}',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: ViewModelAdapter(
        builder: (context, container) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: counterViewModel.increment,
                tooltip: 'Increment',
                child: Icon(Icons.add),
              ),
              SizedBox(
                height: 10.0,
              ),
              FloatingActionButton(
                onPressed: counterViewModel.decrement,
                tooltip: 'Decrement',
                child: Icon(Icons.remove),
              ),
            ],
          );
        },
      ),
    );
  }
}
