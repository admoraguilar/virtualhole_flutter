import 'package:flutter/material.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_api_client_dart/virtualhole_api_client_dart.dart';
import '../virtualhole_client.dart';

class ExplorePage<T> extends StatelessWidget with FlowMapListenerMixin {
  ExplorePage({
    Key key,
    ScrollController scrollController,
    @required this.tabs,
    this.initialTabIndex = 0,
    @required this.bottomNavigationBarOnItemTap,
    @required this.bottomNavigationBarItems,
  })  : assert(tabs != null),
        assert(initialTabIndex != null),
        assert(bottomNavigationBarOnItemTap != null),
        assert(bottomNavigationBarItems != null),
        scrollController = scrollController ?? ScrollController(),
        super(key: key);

  final ScrollController scrollController;
  final List<ContentFeedTab> tabs;
  final int initialTabIndex;
  final Function(int index) bottomNavigationBarOnItemTap;
  final List<BottomNavigationBarItem> bottomNavigationBarItems;

  @override
  void onNavigateSamePage() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        0,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOutCirc,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ContentFeed(
          scrollController: scrollController,
          tabs: tabs,
          initialTabIndex: initialTabIndex,
          onTapMore: (ContentDTO contentDTO) {
            FlowApp.of(context).map.navigate(FromContentCard(contentDTO));
          },
        ),
      ),
      bottomNavigationBarOnItemTap: bottomNavigationBarOnItemTap,
      bottomNavigationBarItems: bottomNavigationBarItems,
      bottomNavigationBarIndex: 0,
    );
  }
}
