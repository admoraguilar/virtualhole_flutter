import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import 'package:virtualhole_api_client_dart/virtualhole_api_client_dart.dart';
import '../../configs/configs.dart';
import '../../ui/ui.dart';

class CreatorPage extends StatelessWidget {
  const CreatorPage({Key key}) : super(key: key);

  Widget _buildAvatarHighlight(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 400,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/suisei-avatar.jpg'),
                fit: BoxFit.cover),
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

  Widget _buildSocialLinks(BuildContext context) {
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

  Widget _buildContentFeed(ContentFeedTab tab) {
    return Column(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    void _onError(APIError error) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('${error.statusCode}: ${error.reasonPhrase}'),
        ),
      );
    }

    VirtualHoleApiClient vHoleApi =
        VirtualHoleApiClient.managed(domain: AppConfig.virtualHoleApi);

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext buildContext, int index) {
        if (index == 0) {
          return _buildAvatarHighlight(context);
        } else if (index == 1) {
          return _buildSocialLinks(context);
        }

        // else if (index == 2) {
        //   return _buildContentFeed(ContentFeedTab(
        //     name: 'Live',
        //     builder: (int page) => APIResponseProvider(
        //       vHoleApi.contents.getLive(ContentRequest(
        //         page: page,
        //         pageSize: 5,
        //       )),
        //       onError: _onError,
        //     ).getResult(),
        //   ));
        // }

        else if (index == 3) {
          return _buildContentFeed(ContentFeedTab(
            name: 'Scheduled',
            builder: (int page) => APIResponseProvider(
              vHoleApi.contents.getDiscover(ContentRequest(
                page: page,
                pageSize: 5,
              )),
              onError: _onError,
            ).getResult(),
          ));
        } else if (index == 4) {
          return _buildContentFeed(ContentFeedTab(
            name: 'Scheduled',
            builder: (int page) => APIResponseProvider(
              vHoleApi.contents.getSchedule(ContentRequest(
                page: page,
                pageSize: 5,
              )),
              onError: _onError,
            ).getResult(),
          ));
        }

        // else if (index == 4) {
        //   return _buildContentFeed(ContentFeedTab(
        //     name: 'Discover',
        //     builder: (int page) => APIResponseProvider(
        //       vHoleApi.contents.getDiscover(ContentRequest(page: page)),
        //       onError: _onError,
        //     ).getResult(),
        //   ));
        // } else if (index == 5) {
        //   return _buildContentFeed(ContentFeedTab(
        //     name: 'Community',
        //     builder: (int page) => APIResponseProvider(
        //       vHoleApi.contents.getCommunity(ContentRequest(page: page)),
        //       onError: _onError,
        //     ).getResult(),
        //   ));
        // }
        return Text('Line $index');
      },
      itemCount: 6,
    );
  }
}
