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
    this.scrollPhysics,
    this.allowRefreshingAndLoading = true,
    @required this.tabs,
    int initialTabIndex,
    this.onSetTab,
    this.errorBuilder,
  })  : assert(scrollDirection != null),
        assert(allowRefreshingAndLoading != null),
        assert(tabs != null && tabs.length > 0),
        initialTabIndex = initialTabIndex == null
            ? 0
            : initialTabIndex > tabs.length
                ? tabs.length - 1
                : initialTabIndex,
        scrollController = scrollController ?? ScrollController(),
        super(key: key);

  final Axis scrollDirection;
  final ScrollController scrollController;
  final ScrollPhysics scrollPhysics;
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

        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data.length > 0) {
            _contentDTOs.addAll(snapshot.data);
            _contentDTOs.removeWhere(
              (ContentDTO contentDTO) => !contentDTO.isAvailable,
            );
          }

          _isFirstLoad = false;
          _isEnd = _page > 0 && snapshot.data.length == 0;
        }

        return Stack(
          children: [
            _ContentFeedBuilder(
              tab: _currentTab,
              header:
                  widget.allowRefreshingAndLoading ? MaterialHeader() : null,
              footer: widget.allowRefreshingAndLoading
                  ? !_isEnd
                      ? MaterialFooter(enableInfiniteLoad: true)
                      : MaterialFooter(enableInfiniteLoad: false)
                  : null,
              scrollDirection: widget.scrollDirection,
              scrollController: widget.scrollController,
              scrollPhysics: widget.scrollPhysics,
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
            if (widget.tabs.length > 1)
              _ContentFeedSelector(
                tabs: widget.tabs,
                onSelect: (ContentFeedTab tab) {
                  setState(() => _setCurrentTab(tab));
                  widget.onSetTab?.call(tab);
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
    ScrollPhysics scrollPhysics,
    @required this.contentDTOs,
    this.isFirstLoad = false,
    @required this.header,
    @required this.footer,
    this.onRefresh,
    this.onLoad,
  })  : assert(tab != null),
        assert(scrollDirection != null),
        assert(contentDTOs != null),
        scrollController = scrollController ?? ScrollController(),
        scrollPhysics = scrollPhysics ?? BouncingScrollPhysics(),
        assert(isFirstLoad != null),
        super(key: key);

  final ContentFeedTab tab;
  final Axis scrollDirection;
  final ScrollController scrollController;
  final ScrollPhysics scrollPhysics;
  final List<ContentDTO> contentDTOs;

  final Header header;
  final Footer footer;
  final bool isFirstLoad;
  final Future<void> Function() onRefresh;
  final Future<void> Function() onLoad;

  bool isEmpty() => !isFirstLoad && contentDTOs.length <= 0;

  @override
  State<StatefulWidget> createState() => _ContentFeedBuilderState();
}

class _ContentFeedBuilderState extends State<_ContentFeedBuilder> {
  @override
  Widget build(BuildContext context) {
    if (widget.isEmpty()) {
      return Center(
        child: Container(
          child: Text(
            'None to show at the moment \n' + 'TMT',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    if (widget.isFirstLoad) {
      return Center(
        child: HololiveRotatingImage(),
      );
    }

    return EasyRefresh(
        header: widget.header,
        footer: widget.footer,
        onRefresh: widget.onRefresh,
        onLoad: widget.onLoad,
        behavior: ScrollBehavior(),
        child: ListView.separated(
          scrollDirection: widget.scrollDirection,
          controller: widget.scrollController,
          physics: widget.scrollPhysics,
          itemBuilder: (BuildContext context, int index) {
            ContentDTO contentDTO = widget.contentDTOs[index];
            return ContentCard(
              content: widget.tab.cardContentBuilder(contentDTO),
              title: widget.tab.cardTitleBuilder(contentDTO),
              creator: widget.tab.cardCreatorBuilder(contentDTO),
              date: widget.tab.cardDateBuilder(contentDTO),
              onTapCard: widget.tab.onTap != null
                  ? () => widget.tab.onTap(contentDTO)
                  : null,
              onTapMore: widget.tab.onTapMore != null
                  ? () => widget.tab.onTapMore(contentDTO)
                  : null,
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: widget.scrollDirection == Axis.vertical ? 8.0 : 0,
              height: widget.scrollDirection == Axis.horizontal ? 8.0 : 0,
            );
          },
          itemCount: widget.contentDTOs.length,
        ));
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
      onTap: onTap ?? this.onTap,
      onTapMore: onTapMore ?? this.onTapMore,
    );
  }
}
