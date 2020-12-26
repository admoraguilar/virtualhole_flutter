import 'package:flutter/material.dart';
import '../../configs/configs.dart';
import '../../ui/ui.dart';

class HomePage extends StatelessWidget {
  HomePage({
    Key key,
    this.scrollController,
  }) : super(key: key);

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ContentFeed(
        scrollController: scrollController,
        tabs: [
          AppContentFeedTab.generateDiscover(),
          AppContentFeedTab.generateCommunity(),
          AppContentFeedTab.generateLive(),
          AppContentFeedTab.generateScheduled()
        ],
        initialTabIndex: 0,
      ),
    );
  }
}
