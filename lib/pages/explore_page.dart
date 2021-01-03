import 'package:flutter/material.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_api_client_dart/virtualhole_api_client_dart.dart';
import '../virtualhole_client.dart';

class ExplorePage extends StatefulWidget {
  ExplorePage({
    Key key,
    ScrollController scrollController,
    @required this.tabs,
    this.initialTabIndex = 0,
    this.onTapCard,
    this.onTapMore,
    this.onSetTab,
  })  : assert(tabs != null),
        scrollController = scrollController ?? ScrollController(),
        super(key: key);

  final ScrollController scrollController;
  final List<ContentFeedTab> tabs;
  final int initialTabIndex;
  final Function(ContentDTO) onTapCard;
  final Function(ContentDTO) onTapMore;
  final Function(ContentFeedTab) onSetTab;

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return FlowMapListener(
      onNavigateSamePage: () {
        if (widget.scrollController.hasClients) {
          widget.scrollController.animateTo(
            0,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOutCirc,
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ContentFeed(
          scrollController: widget.scrollController,
          tabs: widget.tabs,
          initialTabIndex: widget.initialTabIndex,
          onTapCard: widget.onTapCard,
          onTapMore: (ContentDTO contentDTO) {
            FlowApp.of(context).map.navigate(FromContentCard(contentDTO));
            widget.onTapMore?.call(contentDTO);
          },
          onSetTab: widget.onSetTab,
          errorBuilder:
              (BuildContext context, Object exception, StackTrace stackTrace) {
            return ErrorPage(
              onTryAgain: () => setState(() {}),
            );
          },
        ),
      ),
    );
  }
}
