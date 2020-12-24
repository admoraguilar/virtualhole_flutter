import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:virtualhole_flutter/api/api.dart';
import 'package:virtualhole_flutter/client/ui/ui.dart';

class ContentFeed extends StatefulWidget {
  ContentFeed({
    Key key,
    @required this.tabs,
  })  : assert(tabs != null && tabs.length > 0),
        super(key: key);

  final List<ContentFeedTab> tabs;

  @override
  _ContentFeedState createState() => _ContentFeedState();
}

class _ContentFeedState extends State<ContentFeed> {
  List<ContentDTO> _contentDTOs = [];
  ContentFeedTab _currentTab;
  ScrollController _scrollController;
  bool _isLoading = false;

  Future<APIResponse<List<ContentDTO>>> _future;

  @override
  void initState() {
    super.initState();
    _currentTab = widget.tabs[0];
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      ScrollPosition position = _scrollController.position;
      double range = position.maxScrollExtent - position.minScrollExtent;
      double current = position.pixels - position.minScrollExtent;
      double lerp = current / range;

      if (lerp > 0.4 && !_isLoading) {
        _isLoading = true;

        setState(() {
          _currentTab = _currentTab.copyWith(
            request: _currentTab.request.copyWith(
              page: _currentTab.request.page + 1,
            ),
          );
          _future = _currentTab.builder(_currentTab.request);
        });
      }
    });

    _future = _currentTab.builder(_currentTab.request);
  }

  Widget _buildContainer(List<ContentDTO> contentDTOs) {
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: [
          ListView.separated(
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
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 8.0,
              );
            },
            itemCount: contentDTOs.length + 1,
          ),
          Container(
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
                    onTap: () {
                      setState(() {
                        _currentTab = tab;
                        _scrollController.position.jumpTo(0);
                        _contentDTOs.clear();
                        _future = _currentTab.builder(_currentTab.request);
                      });
                    },
                    label: '${tab.name}',
                    labelStyle: TextStyle(fontWeight: FontWeight.w500),
                    labelBackgroundColor: Theme.of(context).accentColor,
                  )
              ],
            ),
          ),
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

  @override
  Widget build(BuildContext context) {
    print('feed build');
    _isLoading = true;

    return FutureBuilder(
      future: _future,
      builder: (BuildContext context,
          AsyncSnapshot<APIResponse<List<ContentDTO>>> snapshot) {
        print(snapshot.connectionState);

        if (snapshot.hasError) {
          throw snapshot.error;
        }

        if (_contentDTOs.length <= 0) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }

        if (snapshot.hasError) {
          throw snapshot.error;
        }

        if (snapshot.hasData) {
          APIResponse<List<ContentDTO>> response = snapshot.data;
          if (response.error != null && _contentDTOs.length <= 0) {
            return Center(
              child: Text(
                  '${response.error.statusCode}: ${response.error.reasonPhrase}'),
            );
          } else if (response.error != null) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(snapshot.error),
              ),
            );
          }
        }

        if (snapshot.hasData &&
            snapshot.connectionState != ConnectionState.waiting) {
          _contentDTOs.addAll(snapshot.data.body);
          _isLoading = false;
        }

        print('Is Loading: $_isLoading');

        _contentDTOs
            .removeWhere((ContentDTO contentDTO) => !contentDTO.isAvailable);
        return _buildContainer(_contentDTOs);
      },
    );
  }
}

class ContentFeedTab {
  ContentFeedTab({
    @required this.name,
    @required this.builder,
    @required this.request,
  });

  final String name;
  final Future<APIResponse<List<ContentDTO>>> Function(ContentRequest) builder;
  final ContentRequest request;

  ContentFeedTab copyWith({
    String name,
    Future<APIResponse<List<ContentDTO>>> Function(ContentRequest) builder,
    ContentRequest request,
  }) {
    return ContentFeedTab(
      name: name ?? this.name,
      builder: builder ?? this.builder,
      request: request ?? this.request,
    );
  }
}
