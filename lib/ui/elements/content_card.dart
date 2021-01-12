import 'package:flutter/material.dart';

class ContentCard extends StatelessWidget {
  const ContentCard({
    Key key,
    @required this.content,
    @required this.title,
    @required this.creator,
    @required this.date,
    this.onTapCard,
    this.onTapMore,
  }) : super(key: key);

  final Widget content;
  final Widget title;
  final Widget creator;
  final Widget date;

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
                  child: content),
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
                            title,
                            SizedBox(height: 3.0),
                            creator,
                            SizedBox(height: 3.0),
                            date
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
