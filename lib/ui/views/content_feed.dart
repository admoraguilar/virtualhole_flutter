import 'dart:math';
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
          fit: StackFit.loose,
          children: [
            _buildFeed(_contentDTOs),
            if (widget.tabs.length > 1) _buildFAB(),
          ],
        );
      },
    );
  }

  Widget _buildFeed(List<ContentDTO> contentDTOs) {
    if (_contentDTOs.length > 0) {
      return ListView.separated(
        scrollDirection: widget.scrollDirection,
        controller: widget.scrollController,
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
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: _buildLoadingIndicator(),
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
    } else if (_contentDTOs.length <= 0 && !_isLoading) {
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
    } else {
      return _buildLoadingIndicator();
    }
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

  Widget _buildLoadingIndicator() {
    List<String> spinners = [
      'assets/images/icons/spinners/coco-512.png',
      'assets/images/icons/spinners/fubuki-512.png',
      'assets/images/icons/spinners/haachama-zoom-512.png',
      'assets/images/icons/spinners/matsuri-512.png',
      'assets/images/icons/spinners/miko-512.png',
      'assets/images/icons/spinners/watame-512.png',
    ];

    Random random = Random();
    return RotatingImage(
      image: Image.asset(spinners[random.nextInt(spinners.length)]).image,
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
