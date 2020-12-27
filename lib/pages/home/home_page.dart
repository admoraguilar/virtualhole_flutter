import 'package:flutter/material.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_api_client_dart/contents/content_dto.dart';
import 'package:virtualhole_api_client_dart/virtualhole_api_client_dart.dart';
import 'package:virtualhole_flutter/configs/configs.dart';
import '../../ui/ui.dart';

class HomePage<T> extends StatelessWidget {
  HomePage({
    Key key,
    ScrollController scrollController,
    @required this.contentFeedTabs,
    this.contentFeedInitialTabIndex = 0,
    @required this.pageBuilder,
    @required this.bottomNavigationBarItems,
  })  : assert(contentFeedTabs != null),
        assert(contentFeedInitialTabIndex != null),
        assert(pageBuilder != null),
        assert(bottomNavigationBarItems != null),
        scrollController = scrollController ?? ScrollController(),
        super(key: key);

  final ScrollController scrollController;
  final List<ContentFeedTab> contentFeedTabs;
  final int contentFeedInitialTabIndex;
  final FlowPage Function(int index) pageBuilder;
  final List<BottomNavigationBarItem> bottomNavigationBarItems;

  @override
  Widget build(BuildContext context) {
    return FlowPageScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ContentFeed(
          scrollController: scrollController,
          tabs: contentFeedTabs,
          initialTabIndex: contentFeedInitialTabIndex,
          onTapMore: (ContentDTO contentDTO) async {
            Creator creator = await AppCreatorFactory.fromIdAsync(
                contentDTO.content.creator.id);
            FlowHandler.get().routerDelegate.setDirty(() {
              FlowHandler.get().routerDelegate.pages.add(
                    AppFlowPageFactory.creator(creator: creator),
                  );
            });
          },
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
