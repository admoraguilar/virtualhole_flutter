import 'package:flutter/material.dart';

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
              print('press');
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
                    print('press');
                  },
                )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext buildContext, int index) {
        if (index == 0) {
          return _buildAvatarHighlight(context);
        } else if (index == 1) {
          return _buildSocialLinks(context);
        }
        return Text('Line $index');
      },
      itemCount: 6,
    );
  }
}
