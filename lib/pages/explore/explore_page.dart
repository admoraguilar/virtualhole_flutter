import 'package:flutter/material.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_api_client_dart/virtualhole_api_client_dart.dart';
import '../../virtualhole_client.dart';

class ExplorePage<T> extends StatelessWidget with FlowMapListenerMixin {
  ExplorePage({
    Key key,
    ScrollController scrollController,
    @required this.contentFeedTabs,
    this.contentFeedInitialTabIndex = 0,
    @required this.onBottomNavigationBarItemTap,
    @required this.bottomNavigationBarItems,
  })  : assert(contentFeedTabs != null),
        assert(contentFeedInitialTabIndex != null),
        assert(onBottomNavigationBarItemTap != null),
        assert(bottomNavigationBarItems != null),
        scrollController = scrollController ?? ScrollController(),
        super(key: key);

  final ScrollController scrollController;
  final List<ContentFeedTab> contentFeedTabs;
  final int contentFeedInitialTabIndex;
  final Function(int index) onBottomNavigationBarItemTap;
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
          tabs: contentFeedTabs,
          initialTabIndex: contentFeedInitialTabIndex,
          onTapMore: (ContentDTO contentDTO) async {
            // Creator creator =
            //     await CreatorFactory.fromIdAsync(contentDTO.content.creator.id);
            // FlowHandler.get().routerDelegate.setDirty(() {
            //   FlowHandler.get().routerDelegate.pages.add(
            //         AppFlowPageFactory.creator(creator: creator),
            //       );
            // });
            FlowApp.of(context).map.navigate(FromContentCard(contentDTO));
          },
        ),
      ),
      onBottomNavigationBarItemTap: onBottomNavigationBarItemTap,
      bottomNavigationBarItems: bottomNavigationBarItems,
      bottomNavigationBarIndex: 0,
    );
  }
}
