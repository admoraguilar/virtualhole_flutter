import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContentCard extends StatelessWidget {
  const ContentCard({
    Key key,
    @required this.title,
    @required this.creatorName,
    @required this.creatorAvatarUrl,
    @required this.creationDateDisplay,
    @required this.thumbnailUrl,
    @required this.url,
  }) : super(
          key: key,
        );

  final String title;
  final String creatorName;
  final String creatorAvatarUrl;
  final String creationDateDisplay;
  final String thumbnailUrl;
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
                    thumbnailUrl,
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
                            title,
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
                                  creatorAvatarUrl,
                                  scale: 1,
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                creatorName,
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
                            creationDateDisplay,
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
      onTap: () => launch(url),
    );
  }
}
