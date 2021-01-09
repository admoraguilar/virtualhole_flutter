import 'package:flutter/material.dart';

class ContentCard extends StatelessWidget {
  const ContentCard({
    Key key,
    @required this.title,
    @required this.creatorName,
    @required this.creatorAvatarUrl,
    @required this.creationDateDisplay,
    @required this.thumbnailUrl,
    @required this.url,
    this.onTapCard,
    this.onTapMore,
  }) : super(key: key);

  final String title;
  final String creatorName;
  final String creatorAvatarUrl;
  final String creationDateDisplay;
  final String thumbnailUrl;
  final String url;

  final Function() onTapCard;
  final Function() onTapMore;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: 250,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: GestureDetector(
          child: Stack(
            alignment: Alignment.bottomCenter,
            fit: StackFit.expand,
            children: [
              Container(
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
                child: Image.network(
                  thumbnailUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 3.0),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 10,
                                  backgroundImage:
                                      NetworkImage(creatorAvatarUrl),
                                ),
                                SizedBox(width: 4),
                                Text(creatorName),
                              ],
                            ),
                            SizedBox(height: 3.0),
                            Text(creationDateDisplay)
                          ],
                        ),
                      ),
                    ),
                    if (onTapMore != null)
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: Icon(Icons.more_vert),
                          onPressed: onTapMore,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          onTap: onTapCard,
        ),
      ),
    );
  }
}
