import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:virtualhole_flutter/client/ui/elements/content_card.dart';

class VideoFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: [
          ListView.builder(
            physics: BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  ContentCard(
                    url: 'https://i.ytimg.com/vi/vQHVGXdcqEQ/mqdefault.jpg',
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                ],
              );
            },
            itemCount: 10,
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
                SpeedDialChild(
                  child: Icon(Icons.accessibility, color: Colors.white),
                  backgroundColor: Colors.deepOrange,
                  onTap: () => print('FIRST CHILD'),
                  label: 'First Child',
                  labelStyle: TextStyle(fontWeight: FontWeight.w500),
                  labelBackgroundColor: Colors.deepOrangeAccent,
                ),
                SpeedDialChild(
                  child: Icon(Icons.brush, color: Colors.white),
                  backgroundColor: Colors.green,
                  onTap: () => print('SECOND CHILD'),
                  label: 'Second Child',
                  labelStyle: TextStyle(fontWeight: FontWeight.w500),
                  labelBackgroundColor: Colors.green,
                ),
                SpeedDialChild(
                  child: Icon(Icons.keyboard_voice, color: Colors.white),
                  backgroundColor: Colors.blue,
                  onTap: () => print('THIRD CHILD'),
                  labelWidget: Container(
                    color: Colors.blue,
                    margin: EdgeInsets.only(right: 10),
                    padding: EdgeInsets.all(6),
                    child: Text('Custom Label Widget'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
