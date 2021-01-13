import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:virtualhole_api_client_dart/virtualhole_api_client_dart.dart';
import '../virtualhole_client.dart';

class CreatorPage extends StatefulWidget {
  const CreatorPage({
    Key key,
    this.creator,
    this.creatorBuilder,
    this.contentFeedTabs,
    this.contentFeedTabBuilder,
  }) : super(key: key);

  final Creator creator;
  final Future<Creator> creatorBuilder;
  final List<ContentFeedTab> Function(Creator) contentFeedTabBuilder;
  final List<ContentFeedTab> contentFeedTabs;

  @override
  _CreatorPageState createState() => _CreatorPageState();
}

class _CreatorPageState extends State<CreatorPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.creatorBuilder != null) {
      return FutureBuilder(
        future: widget.creatorBuilder,
        builder: (BuildContext context, AsyncSnapshot<Creator> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return HololiveRotatingImage();
          }

          if (snapshot.connectionState == ConnectionState.done &&
              (!snapshot.hasData || snapshot.hasError)) {
            return ErrorPage(
              onTryAgain: () => setState(() {}),
            );
          }

          return ListView(
            padding: EdgeInsets.zero,
            children: [
              _CreatorAvatarHighlight(creator: snapshot.data),
              _CreatorSocialLinks(creator: snapshot.data),
              for (ContentFeedTab tab
                  in widget.contentFeedTabBuilder(snapshot.data)) ...[
                _CreatorContentFeed(tab: tab),
                SizedBox(height: 16)
              ]
            ],
            cacheExtent: double.infinity,
          );
        },
      );
    } else {
      return ListView(
        padding: EdgeInsets.zero,
        children: [
          _CreatorAvatarHighlight(creator: widget.creator),
          _CreatorSocialLinks(creator: widget.creator),
          for (ContentFeedTab tab in widget.contentFeedTabs) ...[
            _CreatorContentFeed(tab: tab),
            SizedBox(height: 16)
          ]
        ],
        cacheExtent: double.infinity,
      );
    }
  }
}

class _CreatorAvatarHighlight extends StatelessWidget {
  const _CreatorAvatarHighlight({
    Key key,
    @required this.creator,
  })  : assert(creator != null),
        super(key: key);

  final Creator creator;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 400,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(creator.avatarUrl),
              fit: BoxFit.cover,
            ),
          ),
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Colors.black,
              ],
              begin: Alignment.center,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 400,
          alignment: Alignment.bottomCenter,
          child: Text(
            '${creator.name}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class _CreatorSocialLinks extends StatefulWidget {
  const _CreatorSocialLinks({
    Key key,
    @required this.creator,
  })  : assert(creator != null),
        super(key: key);

  final Creator creator;

  @override
  State<StatefulWidget> createState() => _CreatorSocialLinksState();
}

class _CreatorSocialLinksState extends State<_CreatorSocialLinks> {
  @override
  Widget build(BuildContext context) {
    UserData userData = LocalStorageClient().userData;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          OutlinedButton(
            child: Text(
              'FOLLOW',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            style: OutlinedButton.styleFrom(
              backgroundColor:
                  userData.followedCreatorIds.contains(widget.creator.id)
                      ? Colors.blue
                      : Colors.transparent,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
              side: BorderSide(
                width: 2.0,
                color: Colors.blue,
                style: BorderStyle.solid,
              ),
            ),
            onPressed: () {
              if (userData.followedCreatorIds.contains(widget.creator.id)) {
                userData.followedCreatorIds.remove(widget.creator.id);
              } else {
                userData.followedCreatorIds.add(widget.creator.id);
              }

              LocalStorageClient().write();
              setState(() {});
            },
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              for (CreatorSocial social in widget.creator.socials)
                TextButton(
                  child: Icon(
                    VHIcons().social(social.socialType),
                    color: Colors.white,
                  ),
                  style: TextButton.styleFrom(
                    minimumSize: Size(32, 16),
                    backgroundColor: Colors.blue,
                    shape: CircleBorder(),
                  ),
                  onPressed: () => launch(social.url),
                )
            ],
          )
        ],
      ),
    );
  }
}

class _CreatorContentFeed extends StatelessWidget {
  const _CreatorContentFeed({
    Key key,
    @required this.tab,
  })  : assert(tab != null),
        super(key: key);

  final ContentFeedTab tab;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        height: 250,
        child: ContentFeed(
          scrollDirection: Axis.horizontal,
          allowRefreshingAndLoading: false,
          tabs: [tab],
        ),
      ),
    );
  }
}
