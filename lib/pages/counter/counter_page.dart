import 'package:flutter/material.dart';
import '../../virtualhole_client.dart';

class CounterPage extends StatefulWidget {
  CounterPage({
    Key key,
    this.title,
    this.onBottomNavigationBarItemTap,
    this.bottomNavigationBarItems,
    this.onExtraTap,
  })  : assert(title != null),
        assert(onBottomNavigationBarItemTap != null),
        assert(bottomNavigationBarItems != null),
        super(key: key);

  final Widget title;
  final Function(int index) onBottomNavigationBarItemTap;
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
      onBottomNavigationBarItemTap: widget.onBottomNavigationBarItemTap,
      bottomNavigationBarItems: widget.bottomNavigationBarItems,
      bottomNavigationBarIndex: 1,
    );
  }
}
