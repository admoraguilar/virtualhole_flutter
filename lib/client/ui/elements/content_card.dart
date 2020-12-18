import 'package:flutter/material.dart';

class ContentCard extends StatelessWidget {
  const ContentCard({
    Key key,
    @required this.url,
  }) : super(
          key: key,
        );

  final String url;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 220,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    url,
                    scale: 1,
                  ),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 8,
                    child: Container(
                      // width: double.infinity,
                      height: 220,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '【ころね視点】 日本語と英語で爆弾解除に挑戦する2人【Calliope Mori COLLAB】',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 3.0,
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 8,
                                backgroundImage: NetworkImage(
                                  'https://yt3.ggpht.com/ytc/AAUvwnimjdERaJDGopfH8UaB0r9tr_p8uyuEWWyYVkAd5Q=s900-c-k-c0x00ffffff-no-rj',
                                  scale: 1,
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                'Korone Ch. 戌神ころね',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3.0,
                          ),
                          Text(
                            'Streamed live on Nov 27, 2020',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      child: Container(
                        // padding: const EdgeInsets.all(8.0),
                        width: 50.0,
                        height: 50.0,
                        child: Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                        color: Colors.transparent,
                      ),
                      onTap: () => print('tap more vert'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        color: Colors.black,
      ),
      onTap: () => print('tap content'),
    );
  }
}
