import 'package:flutter/material.dart';
import '../virtualhole_client.dart';

class CounterPage extends StatefulWidget {
  CounterPage({
    Key key,
    this.title,
    this.bottomNavigationBarOnItemTap,
    this.bottomNavigationBarItems,
    this.onExtraTap,
  })  : assert(title != null),
        assert(bottomNavigationBarOnItemTap != null),
        assert(bottomNavigationBarItems != null),
        super(key: key);

  final Widget title;
  final Function(int index) bottomNavigationBarOnItemTap;
  final List<BottomNavigationBarItem> bottomNavigationBarItems;
  final Function() onExtraTap;

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
      title: widget.title,
      body: Align(
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
      ),
      bottomNavigationBarOnItemTap: widget.bottomNavigationBarOnItemTap,
      bottomNavigationBarItems: widget.bottomNavigationBarItems,
      bottomNavigationBarIndex: 1,
    );
  }
}
