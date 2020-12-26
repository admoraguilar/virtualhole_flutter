import 'package:flutter/material.dart';
import 'package:midnight_flutter/flow_handler/flow_handler.dart';
import '../../ui/ui.dart';

class CounterPage extends StatefulWidget {
  CounterPage({
    Key key,
    this.title,
    this.pageBuilder,
    this.bottomNavigationBarItems,
    this.onExtraTap,
  })  : assert(title != null),
        assert(pageBuilder != null),
        assert(bottomNavigationBarItems != null),
        super(key: key);

  final Widget title;
  final FlowPage Function(int index) pageBuilder;
  final List<BottomNavigationBarItem> bottomNavigationBarItems;
  final Function() onExtraTap;

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return RootScaffold(
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
      pageBuilder: widget.pageBuilder,
      bottomNavigationBarItems: widget.bottomNavigationBarItems,
      bottomNavigationBarIndex: 1,
    );
  }
}
