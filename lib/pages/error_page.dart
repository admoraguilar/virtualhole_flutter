import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    Key key,
    this.onTryAgain,
  }) : super(key: key);

  final Function() onTryAgain;

  @override
  Widget build(BuildContext context) {
    return Center(
      key: GlobalKey<NavigatorState>(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Something went wrong!'),
          if (onTryAgain != null) ...[
            SizedBox(
              height: 8.0,
            ),
            OutlinedButton(
              child: Text(
                'Try again',
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
              onPressed: onTryAgain,
            ),
          ]
        ],
      ),
    );
  }
}
