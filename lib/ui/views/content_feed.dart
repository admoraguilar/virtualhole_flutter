import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:virtualhole_api_client_dart/virtualhole_api_client_dart.dart';
import '../../ui/ui.dart';

class ContentFeed extends StatefulWidget {
  ContentFeed({
    Key key,
    @required this.scrollDirection,
    ScrollController scrollController,
    this.allowRefreshingAndLoading = true,
    @required this.tabs,
    int initialTabIndex,
    this.onSetTab,
    this.errorBuilder,
  })  : assert(scrollDirection != null),
        assert(allowRefreshingAndLoading != null),
        assert(tabs != null && tabs.length > 0),
        scrollController = scrollController ?? ScrollController(),
        initialTabIndex = initialTabIndex == null
            ? 0
            : initialTabIndex > tabs.length
                ? tabs.length - 1
                : initialTabIndex,
        super(key: key);

  final Axis scrollDirection;
  final ScrollController scrollController;
  final bool allowRefreshingAndLoading;
  final List<ContentFeedTab> tabs;
  final int initialTabIndex;
  final Function(ContentFeedTab) onSetTab;
  final Widget Function(BuildContext, Object, StackTrace) errorBuilder;

  @override
  _ContentFeedState createState() => _ContentFeedState();
}

class _ContentFeedState extends State<ContentFeed> {
  ContentFeedTab _currentTab;
  List<ContentDTO> _contentDTOs = [];

  Future<List<ContentDTO>> _future;
  int _page = 1;
  bool _isFirstLoad = true;
  bool _isDataProcessed = false;
  bool _isEnd = false;

  @override
  void initState() {
    super.initState();
    _setCurrentTab(widget.tabs[widget.initialTabIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder:
          (BuildContext context, AsyncSnapshot<List<ContentDTO>> snapshot) {
        if (snapshot.hasError) {
          Widget error =
              widget.errorBuilder(context, snapshot.error, StackTrace.current);
          if (error != null) {
            return error;
          }

          throw snapshot.error;
        }

        if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.waiting) {
          _isDataProcessed = false;
        }

        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done &&
            !_isDataProcessed) {
          if (snapshot.data.length > 0) {
            _contentDTOs.addAll(snapshot.data);
            _contentDTOs.removeWhere(
              (ContentDTO contentDTO) => !contentDTO.isAvailable,
            );
          }

          _isFirstLoad = false;
          _isDataProcessed = true;
          _isEnd = _page > 0 && snapshot.data.length == 0;
        }

        return Stack(
          children: [
            IgnorePointer(
              ignoring: _isFirstLoad,
              child: _ContentFeedBuilder(
                tab: _currentTab,
                header:
                    widget.allowRefreshingAndLoading ? MaterialHeader() : null,
                footer: widget.allowRefreshingAndLoading
                    ? !_isEnd
                        ? MaterialFooter(enableInfiniteLoad: true)
                        : MaterialFooter(enableInfiniteLoad: false)
                    : null,
                topBouncing: widget.allowRefreshingAndLoading,
                bottomBouncing: widget.allowRefreshingAndLoading,
                scrollDirection: widget.scrollDirection,
                scrollController: widget.scrollController,
                contentDTOs: _contentDTOs,
                isFirstLoad: _isFirstLoad,
                onRefresh: widget.allowRefreshingAndLoading
                    ? () async {
                        setState(() {
                          _setCurrentTab(_currentTab);
                        });
                      }
                    : null,
                onLoad: widget.allowRefreshingAndLoading
                    ? () async {
                        setState(() {
                          _future = _currentTab.dataProvider(++_page);
                        });
                      }
                    : null,
              ),
            ),
            if (widget.tabs.length > 1)
              _ContentFeedSelector(
                tabs: widget.tabs,
                onSelect: (ContentFeedTab tab) {
                  setState(() {
                    _setCurrentTab(tab);
                    widget.onSetTab?.call(tab);
                  });
                },
              ),
          ],
        );
      },
    );
  }

  void _setCurrentTab(ContentFeedTab tab) {
    assert(tab != null);

    if (_currentTab != null && widget.scrollController.hasClients) {
      widget.scrollController.position.jumpTo(0);
    }

    _currentTab = tab;
    _contentDTOs.clear();
    _page = 1;
    _isFirstLoad = true;
    _future = _currentTab.dataProvider(_page);
  }
}

class _ContentFeedBuilder extends StatefulWidget {
  _ContentFeedBuilder({
    Key key,
    @required this.tab,
    @required this.scrollDirection,
    ScrollController scrollController,
    @required this.contentDTOs,
    this.isFirstLoad = false,
    @required this.header,
    @required this.footer,
    this.topBouncing = false,
    this.bottomBouncing = false,
    this.onRefresh,
    this.onLoad,
  })  : assert(tab != null),
        assert(scrollDirection != null),
        assert(contentDTOs != null),
        scrollController = scrollController ?? ScrollController(),
        assert(isFirstLoad != null),
        assert(topBouncing != null),
        assert(bottomBouncing != null),
        super(key: key);

  final ContentFeedTab tab;
  final Axis scrollDirection;
  final ScrollController scrollController;
  final List<ContentDTO> contentDTOs;

  final bool isFirstLoad;
  final Header header;
  final Footer footer;
  final bool topBouncing;
  final bool bottomBouncing;
  final Future<void> Function() onRefresh;
  final Future<void> Function() onLoad;

  bool isEmpty() => !isFirstLoad && contentDTOs.length <= 0;

  @override
  State<StatefulWidget> createState() => _ContentFeedBuilderState();
}

class _ContentFeedBuilderState extends State<_ContentFeedBuilder> {
  @override
  Widget build(BuildContext context) {
    return widget.scrollDirection == Axis.vertical
        ? _ContentFeedVertical(feedBuilder: widget)
        : _ContentFeedHorizontal(feedBuilder: widget);
  }
}

class _ContentFeedVertical extends StatelessWidget {
  _ContentFeedVertical({
    Key key,
    @required this.feedBuilder,
  })  : assert(feedBuilder != null),
        super(key: key);

  final _ContentFeedBuilder feedBuilder;

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      header: feedBuilder.header,
      footer: feedBuilder.footer,
      topBouncing: feedBuilder.topBouncing,
      bottomBouncing: feedBuilder.bottomBouncing,
      onRefresh: feedBuilder.onRefresh,
      onLoad: feedBuilder.onLoad,
      scrollController: feedBuilder.scrollController,
      child: CustomScrollView(
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            sliver: SliverToBoxAdapter(
              child: Text(
                '${feedBuilder.tab.name}',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (feedBuilder.isFirstLoad)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: HololiveRotatingImage(),
              ),
            ),
          if (feedBuilder.isEmpty())
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Container(
                  child: Text(
                    'None to show at the moment \n' + 'TMT',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          if (!feedBuilder.isFirstLoad && !feedBuilder.isEmpty())
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (index.isEven) {
                    int localIndex = index ~/ 2;
                    ContentDTO contentDTO = feedBuilder.contentDTOs[localIndex];
                    return ContentCard(
                      content: feedBuilder.tab.cardContentBuilder(contentDTO),
                      title: feedBuilder.tab.cardTitleBuilder(contentDTO),
                      creator: feedBuilder.tab.cardCreatorBuilder(contentDTO),
                      date: feedBuilder.tab.cardDateBuilder(contentDTO),
                      indicator: feedBuilder.tab.cardIndicatorBuilder != null
                          ? feedBuilder.tab.cardIndicatorBuilder(contentDTO)
                          : null,
                      onTapCard: feedBuilder.tab.onTap != null
                          ? () => feedBuilder.tab.onTap(contentDTO)
                          : null,
                      onTapMore: feedBuilder.tab.onTapMore != null
                          ? () => feedBuilder.tab.onTapMore(contentDTO)
                          : null,
                    );
                  }

                  return SizedBox(
                    width:
                        feedBuilder.scrollDirection == Axis.vertical ? 8.0 : 0,
                    height: feedBuilder.scrollDirection == Axis.horizontal
                        ? 8.0
                        : 0,
                  );
                },
                childCount: (feedBuilder.contentDTOs.length * 2) - 1,
              ),
            )
        ],
      ),
    );
  }
}

class _ContentFeedHorizontal extends StatelessWidget {
  _ContentFeedHorizontal({
    Key key,
    @required this.feedBuilder,
  })  : assert(feedBuilder != null),
        super(key: key);

  final _ContentFeedBuilder feedBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${feedBuilder.tab.name}',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        if (feedBuilder.isFirstLoad)
          Expanded(
            child: Center(
              child: HololiveRotatingImage(),
            ),
          ),
        if (feedBuilder.isEmpty())
          Expanded(
            child: Center(
              child: Container(
                child: Text(
                  'None to show at the moment \n' + 'TMT',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        if (!feedBuilder.isFirstLoad && !feedBuilder.isEmpty())
          Expanded(
            child: EasyRefresh(
              header: feedBuilder.header,
              footer: feedBuilder.footer,
              topBouncing: feedBuilder.topBouncing,
              bottomBouncing: feedBuilder.bottomBouncing,
              onRefresh: feedBuilder.onRefresh,
              onLoad: feedBuilder.onLoad,
              scrollController: feedBuilder.scrollController,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  ContentDTO contentDTO = feedBuilder.contentDTOs[index];
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ContentCard(
                      content: feedBuilder.tab.cardContentBuilder(contentDTO),
                      title: feedBuilder.tab.cardTitleBuilder(contentDTO),
                      creator: feedBuilder.tab.cardCreatorBuilder(contentDTO),
                      date: feedBuilder.tab.cardDateBuilder(contentDTO),
                      indicator: feedBuilder.tab.cardIndicatorBuilder != null
                          ? feedBuilder.tab.cardIndicatorBuilder(contentDTO)
                          : null,
                      onTapCard: feedBuilder.tab.onTap != null
                          ? () => feedBuilder.tab.onTap(contentDTO)
                          : null,
                      onTapMore: feedBuilder.tab.onTapMore != null
                          ? () => feedBuilder.tab.onTapMore(contentDTO)
                          : null,
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width:
                        feedBuilder.scrollDirection == Axis.vertical ? 8.0 : 0,
                    height: feedBuilder.scrollDirection == Axis.horizontal
                        ? 8.0
                        : 0,
                  );
                },
                itemCount: feedBuilder.contentDTOs.length,
              ),
            ),
          ),
      ],
    );
  }
}

class _ContentFeedSelector extends StatelessWidget {
  const _ContentFeedSelector({
    Key key,
    @required this.tabs,
    @required this.onSelect,
  })  : assert(tabs != null),
        assert(onSelect != null),
        super(key: key);

  final List<ContentFeedTab> tabs;
  final Function(ContentFeedTab) onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      child: SpeedDial(
        child: CircleAvatar(
          backgroundImage:
              AssetImage('assets/images/icons/virtualhole-512.png'),
          radius: 25,
        ),
        animationSpeed: 300,
        overlayOpacity: .3,
        overlayColor: Theme.of(context).backgroundColor,
        marginBottom: 30,
        marginRight: 30,
        curve: Curves.easeOutCirc,
        children: [
          for (ContentFeedTab tab in tabs)
            SpeedDialChild(
              child: tab.icon,
              backgroundColor: Theme.of(context).accentColor,
              onTap: () => onSelect(tab),
              label: '${tab.name}',
              labelStyle: TextStyle(fontWeight: FontWeight.w500),
              labelBackgroundColor: Theme.of(context).accentColor,
            )
        ],
      ),
    );
  }
}

class ContentFeedTab {
  const ContentFeedTab({
    @required this.name,
    @required this.icon,
    @required this.dataProvider,
    @required this.cardContentBuilder,
    @required this.cardTitleBuilder,
    @required this.cardCreatorBuilder,
    @required this.cardDateBuilder,
    this.cardIndicatorBuilder,
    @required this.onTap,
    this.onTapMore,
  })  : assert(name != null),
        assert(icon != null),
        assert(dataProvider != null),
        assert(cardContentBuilder != null),
        assert(cardTitleBuilder != null),
        assert(cardCreatorBuilder != null),
        assert(cardDateBuilder != null),
        assert(onTap != null);

  final String name;
  final Widget icon;
  final Future<List<ContentDTO>> Function(int page) dataProvider;
  final Widget Function(ContentDTO) cardContentBuilder;
  final Widget Function(ContentDTO) cardTitleBuilder;
  final Widget Function(ContentDTO) cardCreatorBuilder;
  final Widget Function(ContentDTO) cardDateBuilder;
  final Widget Function(ContentDTO) cardIndicatorBuilder;
  final Function(ContentDTO) onTap;
  final Function(ContentDTO) onTapMore;

  ContentFeedTab copyWith({
    String name,
    Widget icon,
    Future<List<ContentDTO>> Function(int page) dataProvider,
    Widget Function(ContentDTO) cardContentBuilder,
    Widget Function(ContentDTO) cardTitleBuilder,
    Widget Function(ContentDTO) cardCreatorBuilder,
    Widget Function(ContentDTO) cardDateBuilder,
    Widget Function(ContentDTO) cardIndicatorBuilder,
    Function(ContentDTO) onTap,
    Function(ContentDTO) onTapMore,
  }) {
    return ContentFeedTab(
      name: name ?? this.name,
      icon: icon ?? this.icon,
      dataProvider: dataProvider ?? this.dataProvider,
      cardContentBuilder: cardContentBuilder ?? this.cardContentBuilder,
      cardTitleBuilder: cardTitleBuilder ?? this.cardTitleBuilder,
      cardCreatorBuilder: cardCreatorBuilder ?? this.cardCreatorBuilder,
      cardDateBuilder: cardDateBuilder ?? this.cardDateBuilder,
      cardIndicatorBuilder: cardIndicatorBuilder ?? this.cardIndicatorBuilder,
      onTap: onTap ?? this.onTap,
      onTapMore: onTapMore ?? this.onTapMore,
    );
  }
}
