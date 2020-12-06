import 'package:flutter/material.dart';
import 'package:virtualhole_flutter/common/common.dart';
import 'package:virtualhole_flutter/client/widgets/widgets.dart';
import 'package:virtualhole_flutter/client/viewmodels/viewmodels.dart';

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
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ContentCard(
              url: 'https://i.ytimg.com/vi/wtEqQ2HS08U/hq720.jpg',
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              'You have pushed the button this many times:',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            ViewModelAdapter(
              observables: (context, container) {
                return [counterViewModel.counter];
              },
              builder: (context, container) {
                return Text(
                  '${counterViewModel.counter.value}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Discover',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.flash_on),
          //   label: 'Feed',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Support',
          ),
        ],
        currentIndex: 0,
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (i) {
          print(i);
        },
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
