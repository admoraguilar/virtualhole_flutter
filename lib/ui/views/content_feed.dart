import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_api_client_dart/virtualhole_api_client_dart.dart';
import '../../ui/ui.dart';

class ContentFeed extends StatefulWidget {
  ContentFeed({
    Key key,
    this.scrollDirection = Axis.vertical,
    ScrollController scrollController,
    @required this.tabs,
    this.initialTabIndex = 0,
  })  : assert(scrollDirection != null),
        assert(tabs != null && tabs.length > 0),
        assert(initialTabIndex != null &&
            initialTabIndex >= 0 &&
            initialTabIndex < tabs.length),
        scrollController = scrollController ?? ScrollController(),
        super(key: key);

  final Axis scrollDirection;
  final ScrollController scrollController;
  final List<ContentFeedTab> tabs;
  final int initialTabIndex;

  @override
  _ContentFeedState createState() => _ContentFeedState();
}

class _ContentFeedState extends State<ContentFeed> {
  ContentFeedTab _currentTab;
  List<ContentDTO> _contentDTOs = [];
  bool _isLoading = false;
  int _page = 1;
  Future<List<ContentDTO>> _future;

  @override
  void initState() {
    super.initState();

    widget.scrollController.addListener(() {
      if (widget.scrollController.position.normalizedScrollExtent > 0.4 &&
          !_isLoading) {
        _isLoading = true;
        setState(() {
          _future = _currentTab.builder(++_page);
        });
      }
    });

    _setCurrentTab(widget.tabs[widget.initialTabIndex]);
  }

  @override
  Widget build(BuildContext context) {
    _isLoading = true;

    return FutureBuilder(
      future: _future,
      builder:
          (BuildContext context, AsyncSnapshot<List<ContentDTO>> snapshot) {
        MLog.log(snapshot.connectionState);

        if (snapshot.hasError) {
          throw snapshot.error;
        }

        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          _contentDTOs.addAll(snapshot.data);
          _contentDTOs.removeWhere(
            (ContentDTO contentDTO) => !contentDTO.isAvailable,
          );
          _isLoading = false;
        }

        return Stack(
          children: [
            _ContentFeedBuilder(
              isLoading: _isLoading,
              scrollDirection: widget.scrollDirection,
              scrollController: widget.scrollController,
              contentDTOs: _contentDTOs,
            ),
            if (widget.tabs.length > 1)
              _ContentFeedSelector(
                tabs: widget.tabs,
                onSetTab: (ContentFeedTab tab) =>
                    setState(() => _setCurrentTab(tab)),
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
    _future = _currentTab.builder(_page);
  }
}

class _ContentFeedBuilder extends StatelessWidget {
  _ContentFeedBuilder({
    Key key,
    @required this.isLoading,
    @required this.scrollDirection,
    @required this.scrollController,
    @required this.contentDTOs,
  })  : assert(isLoading != null),
        assert(scrollDirection != null),
        assert(scrollController != null),
        assert(contentDTOs != null),
        super(key: key);

  final bool isLoading;
  final Axis scrollDirection;
  final ScrollController scrollController;
  final List<ContentDTO> contentDTOs;

  @override
  Widget build(BuildContext context) {
    if (contentDTOs.length > 0) {
      return ListView.separated(
        scrollDirection: scrollDirection,
        controller: scrollController,
        physics: BouncingScrollPhysics(),
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
        itemCount: contentDTOs.length + 1,
      );
    } else if (contentDTOs.length <= 0 && !isLoading) {
      return Center(
        child: Container(
          child: Text(
            'None to show at the moment \n' + 'TWT',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    } else {
      return HololiveRotatingImage();
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
        child: Icon(Icons.ac_unit),
        animationSpeed: 300,
        overlayOpacity: .3,
        overlayColor: Theme.of(context).backgroundColor,
        marginBottom: 30,
        marginRight: 30,
        curve: Curves.easeOutCirc,
        children: [
          for (ContentFeedTab tab in tabs)
            SpeedDialChild(
              child: Icon(Icons.tab, color: Colors.white),
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
    @required this.builder,
  });

  final String name;
  final Future<List<ContentDTO>> Function(int page) builder;

  ContentFeedTab copyWith({
    String name,
    Future<List<ContentDTO>> Function(int page) builder,
  }) {
    return ContentFeedTab(
      name: name ?? this.name,
      builder: builder ?? this.builder,
    );
  }
}
