import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  CounterPage({
    Key key,
    this.onExtraTap,
  }) : super(key: key);

  final Function() onExtraTap;

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Count: $_counter'),
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              setState(() {
                _counter++;
              });

              print(_counter);
            },
          ),
          FloatingActionButton(
            child: Icon(Icons.remove),
            onPressed: () {
              setState(() {
                _counter--;
              });
              print(_counter);
            },
          ),
          FloatingActionButton(
            child: Icon(Icons.settings),
            onPressed: widget.onExtraTap,
          ),
        ],
      ),
    );
  }
}
