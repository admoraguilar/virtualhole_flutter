import 'package:flutter/material.dart';
import 'package:virtualhole_flutter/client/viewmodels/viewmodels.dart';
import 'package:virtualhole_flutter/common/common.dart';

class ContentCard extends StatelessWidget {
  const ContentCard({
    Key key,
    @required this.url,
  }) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 220,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(url, scale: 1),
                    fit: BoxFit.cover,
                  ),
                ),
                foregroundDecoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black],
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // width: double.infinity,
                    height: 220,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Video Title",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            Image(
                              image: NetworkImage(
                                  'https://yt3.ggpht.com/ytc/AAUvwnimjdERaJDGopfH8UaB0r9tr_p8uyuEWWyYVkAd5Q=s900-c-k-c0x00ffffff-no-rj',
                                  scale: 1),
                              width: 20,
                              height: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Korone Ch.",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "10/10/2020",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      // padding: const EdgeInsets.all(8.0),
                      width: 50.0,
                      height: 50.0,
                      child: Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      ),
                      color: Colors.transparent,
                    ),
                    onTap: () => print('tap more vert'),
                  ),
                ],
              ),
            ],
          ),
        ),
        color: Colors.black,
      ),
      onTap: () => print('tap content'),
    );
  }
}

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
            ContentCard(
              url: 'https://i.ytimg.com/vi/wtEqQ2HS08U/hq720.jpg',
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              'You have pushed the button this many times:',
            ),
            ViewModelAdapter(
              observables: (context, container) {
                return [counterViewModel.counter];
              },
              builder: (context, container) {
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
