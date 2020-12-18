import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Flow Scaffold!'),
    );
    // PageNavigatorViewModel pageNavigatorViewModel =
    //     ViewModel.get<PageNavigatorViewModel>();

    // return ViewModelAdapter(
    //   observables: (BuildContext context) => [
    //     pageNavigatorViewModel,
    //   ],
    //   builder: (BuildContext context) {
    //     return Scaffold(
    //       backgroundColor: Colors.black,
    //       body: WillPopScope(
    //         onWillPop: () async {
    //           bool shouldExit = !pageNavigatorViewModel.pages.state.canPop();
    //           if (!shouldExit) {
    //             pageNavigatorViewModel.pages.state.pop();
    //           }
    //           pageNavigatorViewModel.update();
    //           return shouldExit;
    //         },
    //         child: Navigator(
    //           key: pageNavigatorViewModel.pages.key,
    //           onGenerateInitialRoutes:
    //               (NavigatorState state, String initialPage) =>
    //                   pageNavigatorViewModel.pages
    //                       .generateInitialRoutes(initialPage),
    //           onGenerateRoute: pageNavigatorViewModel.pages.generateRoute,
    //         ),
    //       ),
    //       bottomNavigationBar: BottomNavigationBar(
    //         items: [
    //           BottomNavigationBarItem(
    //             icon: Icon(Icons.home),
    //             label: 'Discover',
    //           ),
    //           BottomNavigationBarItem(
    //             icon: Icon(Icons.list),
    //             label: 'Feed',
    //           ),
    //           BottomNavigationBarItem(
    //             icon: Icon(Icons.search),
    //             label: 'Search',
    //           ),
    //           BottomNavigationBarItem(
    //             icon: Icon(Icons.favorite),
    //             label: 'Support',
    //           ),
    //         ],
    //         currentIndex: pageNavigatorViewModel.pages.activeIndex,
    //         backgroundColor: Colors.black,
    //         unselectedItemColor: Colors.grey,
    //         type: BottomNavigationBarType.fixed,
    //         onTap: (i) {
    //           if (i == 0) {
    //             pageNavigatorViewModel.pages.state
    //                 .pushNamed(PageNavigatorKey.discover);
    //           } else if (i == 3) {
    //             pageNavigatorViewModel.pages.state
    //                 .pushNamed(PageNavigatorKey.support);
    //           }

    //           pageNavigatorViewModel.update();
    //         },
    //       ),
    //       floatingActionButton: Column(
    //         mainAxisAlignment: MainAxisAlignment.end,
    //         children: [
    //           // FloatingActionButton(
    //           //   onPressed: counterViewModel.increment,
    //           //   tooltip: 'Increment',
    //           //   child: Icon(Icons.add),
    //           // ),
    //           // SizedBox(
    //           //   height: 10.0,
    //           // ),
    //           // FloatingActionButton(
    //           //   onPressed: counterViewModel.decrement,
    //           //   tooltip: 'Decrement',
    //           //   child: Icon(Icons.remove),
    //           // ),
    //         ],
    //       ),
    //     );
    //   },
    // );
  }
}
