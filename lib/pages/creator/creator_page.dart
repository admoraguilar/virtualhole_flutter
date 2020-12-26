import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import '../../ui/ui.dart';

class CreatorPage extends StatelessWidget {
  const CreatorPage({
    Key key,
    @required this.contentFeedTabs,
    @required this.pageBuilder,
    @required this.bottomNavigationBarItems,
  })  : assert(contentFeedTabs != null),
        assert(pageBuilder != null),
        assert(bottomNavigationBarItems != null),
        super(key: key);

  final List<ContentFeedTab> contentFeedTabs;
  final FlowPage Function(int index) pageBuilder;
  final List<BottomNavigationBarItem> bottomNavigationBarItems;

  @override
  Widget build(BuildContext context) {
    return RootScaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          _CreatorAvatarHighlight(),
          _CreatorSocialLinks(),
          for (ContentFeedTab tab in contentFeedTabs) ...[
            _CreatorContentFeed(tab: tab),
            SizedBox(height: 16)
          ]
        ],
        cacheExtent: double.infinity,
      ),
      pageBuilder: pageBuilder,
      bottomNavigationBarItems: bottomNavigationBarItems,
    );
  }
}

class _CreatorAvatarHighlight extends StatelessWidget {
  const _CreatorAvatarHighlight({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 400,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/suisei-avatar.jpg'),
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
            'Suisei Hoshimachi',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
      ],
    );
  }
}

class _CreatorSocialLinks extends StatelessWidget {
  const _CreatorSocialLinks({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              // backgroundColor: Colors.blue,
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
              MLog.log('press');
            },
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < 4; i++)
                TextButton(
                  child: Icon(
                    Icons.music_note,
                    color: Colors.white,
                  ),
                  style: TextButton.styleFrom(
                    minimumSize: Size(32, 16),
                    backgroundColor: Colors.blue,
                    shape: CircleBorder(),
                  ),
                  onPressed: () {
                    MLog.log('press');
                  },
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${tab.name}',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(
            height: 250,
            child: ContentFeed(
              scrollDirection: Axis.horizontal,
              scrollPhysics: ClampingScrollPhysics(),
              shouldLoadMoreOnScroll: false,
              tabs: [tab],
            ),
          ),
        ],
      ),
    );
  }
}
