import 'package:flutter/material.dart';
import 'package:virtualhole_flutter/client/ui/elements/content_card.dart';

class VideoFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              ContentCard(
                url: 'https://i.ytimg.com/vi/aqVluRmvNXM/mqdefault.jpg',
              ),
              SizedBox(
                height: 8.0,
              ),
            ],
          );
        },
        itemCount: 10,
      ),
    );
  }
}
