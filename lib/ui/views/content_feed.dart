import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_api_client_dart/virtualhole_api_client_dart.dart';
import '../../ui/ui.dart';

class ContentFeed extends StatefulWidget {
  ContentFeed({
    Key key,
    @required this.scrollDirection,
    ScrollController scrollController,
    this.scrollPhysics,
    this.shouldLoadMoreOnScroll = true,
    @required this.tabs,
    int initialTabIndex,
    this.onSetTab,
    this.errorBuilder,
  })  : assert(scrollDirection != null),
        assert(shouldLoadMoreOnScroll != null),
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
  final bool shouldLoadMoreOnScroll;
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
  bool _isLoading = false;
  bool _isEnd = false;
  int _page = 1;
  Future<List<ContentDTO>> _future;

  @override
  void initState() {
    super.initState();

    if (widget.shouldLoadMoreOnScroll) {
      widget.scrollController.addListener(() {
        if (widget.scrollController.position.normalizedScrollExtent > 0.4 &&
            !_isLoading &&
            !_isEnd) {
          _isLoading = true;
          setState(() {
            _future = _currentTab.dataProvider(++_page);
          });
        }
      });
    }

    _setCurrentTab(widget.tabs[widget.initialTabIndex]);
  }

  @override
  Widget build(BuildContext context) {
    _isLoading = true;

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
          int lastLength = _contentDTOs.length;

          if (snapshot.data.length > 0) {
            _contentDTOs.addAll(snapshot.data);
            _contentDTOs.removeWhere(
              (ContentDTO contentDTO) => !contentDTO.isAvailable,
            );
          }

          _isLoading = false;
          _isEnd = lastLength == _contentDTOs.length;
        }

        return Stack(
          children: [
            _ContentFeedBuilder(
              isLoading: _isLoading,
              isEnd: _isEnd,
              scrollDirection: widget.scrollDirection,
              scrollController: widget.scrollController,
              scrollPhysics: widget.scrollPhysics,
              shouldLoadMoreOnScroll: widget.shouldLoadMoreOnScroll,
              contentDTOs: _contentDTOs,
              onTapCard: _currentTab.onTap,
              onTapMore: _currentTab.onTapMore,
            ),
            if (widget.tabs.length > 1)
              _ContentFeedSelector(
                tabs: widget.tabs,
                onSetTab: (ContentFeedTab tab) {
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
    _isLoading = false;
    _isEnd = false;
    _future = _currentTab.dataProvider(_page);
  }
}

class _ContentFeedBuilder extends StatelessWidget {
  _ContentFeedBuilder({
    Key key,
    @required this.isLoading,
    @required this.isEnd,
    @required this.scrollDirection,
    ScrollController scrollController,
    ScrollPhysics scrollPhysics,
    this.shouldLoadMoreOnScroll = true,
    @required this.contentDTOs,
    this.onTapCard,
    this.onTapMore,
  })  : assert(isLoading != null),
        assert(scrollDirection != null),
        assert(shouldLoadMoreOnScroll != null),
        assert(contentDTOs != null),
        scrollController = scrollController ?? ScrollController(),
        scrollPhysics = scrollPhysics ?? BouncingScrollPhysics(),
        super(key: key);

  final bool isLoading;
  final bool isEnd;
  final Axis scrollDirection;
  final ScrollController scrollController;
  final ScrollPhysics scrollPhysics;
  final bool shouldLoadMoreOnScroll;
  final List<ContentDTO> contentDTOs;
  final Function(ContentDTO) onTapCard;
  final Function(ContentDTO) onTapMore;

  @override
  Widget build(BuildContext context) {
    if (contentDTOs.length > 0) {
      return ListView.separated(
        scrollDirection: scrollDirection,
        controller: scrollController,
        physics: scrollPhysics,
        itemBuilder: (BuildContext context, int index) {
          if (index < contentDTOs.length) {
            ContentDTO contentDTO = contentDTOs[index];
            return ContentCard(
              title: contentDTO.content.title,
              creatorName: contentDTO.content.creator.name,
              creatorAvatarUrl: contentDTO.content.creator.avatarUrl,
              creationDateDisplay: contentDTO.creationDateDisplay,
              thumbnailUrl: contentDTO.content.thumbnailUrl,
              url: contentDTO.content.url,
              onTapCard: onTapCard != null ? () => onTapCard(contentDTO) : null,
              onTapMore: onTapMore != null ? () => onTapMore(contentDTO) : null,
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: HololiveRotatingImage(),
            );
          }
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: scrollDirection == Axis.vertical ? 8.0 : 0,
            height: scrollDirection == Axis.horizontal ? 8.0 : 0,
          );
        },
        itemCount: _getListCount(),
      );
    } else if (contentDTOs.length <= 0 && !isLoading) {
      return Center(
        child: Container(
          child: Text(
            'None to show at the moment \n' + 'TMT',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    } else {
      return HololiveRotatingImage();
    }
  }

  int _getListCount() {
    if (isEnd) {
      return contentDTOs.length;
    } else {
      return shouldLoadMoreOnScroll
          ? contentDTOs.length + 1
          : contentDTOs.length;
    }
  }
}

class _ContentFeedSelector extends StatelessWidget {
  const _ContentFeedSelector({
    Key key,
    @required this.tabs,
    @required this.onSetTab,
  })  : assert(tabs != null),
        assert(onSetTab != null),
        super(key: key);

  final List<ContentFeedTab> tabs;
  final Function(ContentFeedTab) onSetTab;

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
              onTap: () => onSetTab(tab),
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
    @required this.onTap,
    this.onTapMore,
  })  : assert(name != null),
        assert(icon != null),
        assert(dataProvider != null),
        assert(onTap != null);

  final String name;
  final Widget icon;
  final Future<List<ContentDTO>> Function(int page) dataProvider;
  final Function(ContentDTO) onTap;
  final Function(ContentDTO) onTapMore;

  ContentFeedTab copyWith({
    String name,
    Widget icon,
    Future<List<ContentDTO>> Function(int page) builder,
    Function(ContentDTO) onTap,
    Function(ContentDTO) onTapMore,
  }) {
    return ContentFeedTab(
      name: name ?? this.name,
      icon: icon ?? this.icon,
      dataProvider: builder ?? this.dataProvider,
      onTap: onTap ?? this.onTap,
      onTapMore: onTapMore ?? this.onTapMore,
    );
  }
}
