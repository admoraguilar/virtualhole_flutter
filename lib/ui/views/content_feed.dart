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
    @required this.tabs,
    this.initialTabIndex = 0,
  })  : assert(scrollDirection != null),
        assert(tabs != null && tabs.length > 0),
        assert(initialTabIndex != null &&
            initialTabIndex >= 0 &&
            initialTabIndex < tabs.length),
        super(key: key);

  final Axis scrollDirection;
  final List<ContentFeedTab> tabs;
  final int initialTabIndex;

  @override
  _ContentFeedState createState() => _ContentFeedState();
}

class _ContentFeedState extends State<ContentFeed> {
  ScrollController _scrollController = ScrollController();
  ContentFeedTab _currentTab;
  List<ContentDTO> _contentDTOs = [];
  bool _isLoading = false;
  int _page = 1;
  Future<List<ContentDTO>> _future;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.normalizedScrollExtent > 0.4 &&
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
          fit: StackFit.expand,
          children: [
            if (_isLoading) _buildLoadingIndicator(),
            if (!_isLoading) _buildFeed(_contentDTOs),
            _buildFAB(),
          ],
        );
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildFeed(List<ContentDTO> contentDTOs) {
    if (_contentDTOs.length > 0) {
      return ListView.separated(
        controller: _scrollController,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          if (index < contentDTOs.length) {
            ContentDTO contentDTO = contentDTOs[index];
            return ContentCard(
              title: contentDTO.content.title,
              creatorName: contentDTO.content.creator.name,
              creatorAvatarUrl: contentDTO.content.creator.avatarUrl,
              creationDateDisplay: contentDTO.creationDateDisplay,
              thumbnailUrl: _getContentThumbnail(contentDTO),
              url: contentDTO.content.url,
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 8.0,
          );
        },
        itemCount: contentDTOs.length + 1,
      );
    } else if (_contentDTOs.length <= 0) {
      return Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        child: Text(
          'None to show at the moment \n' + 'TWT',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      );
    }

    throw Exception('[${(ContentFeed).toString()}] Unsupported operation.');
  }

  Widget _buildFAB() {
    return Container(
      alignment: Alignment.bottomRight,
      child: SpeedDial(
        child: Icon(Icons.ac_unit),
        animationSpeed: 150 * 1,
        overlayOpacity: .3,
        overlayColor: Theme.of(context).backgroundColor,
        marginBottom: 30,
        marginRight: 30,
        curve: Curves.easeOutExpo,
        children: [
          for (ContentFeedTab tab in widget.tabs)
            SpeedDialChild(
              child: Icon(Icons.tab, color: Colors.white),
              backgroundColor: Theme.of(context).accentColor,
              onTap: () => setState(() => _setCurrentTab(tab)),
              label: '${tab.name}',
              labelStyle: TextStyle(fontWeight: FontWeight.w500),
              labelBackgroundColor: Theme.of(context).accentColor,
            )
        ],
      ),
    );
  }

  String _getContentThumbnail(ContentDTO contentDTO) {
    Content content = contentDTO.content;
    if (content.socialType == SocialType.youtube) {
      if (content.contentType == ContentType.video) {
        return (content as YouTubeVideo).thumbnailUrl;
      } else if (content.contentType == ContentType.broadcast) {
        return (content as YouTubeBroadcast).thumbnailUrl;
      }
    }
    return '';
  }

  void _setCurrentTab(ContentFeedTab tab) {
    assert(tab != null);

    if (_currentTab != null && _scrollController.hasClients) {
      _scrollController.position.jumpTo(0);
    }

    _currentTab = tab;
    _contentDTOs.clear();
    _page = 1;
    _isLoading = false;
    _future = _currentTab.builder(_page);
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
