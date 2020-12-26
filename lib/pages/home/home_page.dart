import 'package:flutter/material.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import '../../ui/ui.dart';

class HomePage<T> extends StatelessWidget {
  HomePage({
    Key key,
    ScrollController scrollController,
    @required this.contentFeedTabs,
    this.contentFeedInitialTabIndex,
    @required this.pageBuilder,
    @required this.bottomNavigationBarItems,
  })  : scrollController = scrollController ?? ScrollController(),
        super(key: key);

  final ScrollController scrollController;
  final List<ContentFeedTab> contentFeedTabs;
  final int contentFeedInitialTabIndex;
  final FlowPage Function(int index) pageBuilder;
  final List<BottomNavigationBarItem> bottomNavigationBarItems;

  @override
  Widget build(BuildContext context) {
    return RootScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ContentFeed(
          scrollController: scrollController,
          tabs: contentFeedTabs,
          initialTabIndex: contentFeedInitialTabIndex,
        ),
      ),
      pageBuilder: pageBuilder,
      bottomNavigationBarItems: bottomNavigationBarItems,
      bottomNavigationBarIndex: 0,
      onBottomNavigateSamePage: () {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            0,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOutCirc,
          );
        }
      },
    );
  }
}
