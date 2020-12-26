import 'dart:math';
import 'package:flutter/material.dart';

class HololiveRotatingImage extends StatelessWidget {
  static final List<String> _spinners = [
    'assets/images/icons/spinners/coco-512.png',
    'assets/images/icons/spinners/fubuki-512.png',
    'assets/images/icons/spinners/haachama-zoom-512.png',
    'assets/images/icons/spinners/matsuri-512.png',
    'assets/images/icons/spinners/miko-512.png',
    'assets/images/icons/spinners/watame-512.png',
  ];

  static final Random _random = Random();

  const HololiveRotatingImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int index = _random.nextInt(_spinners.length);
    return RotatingImage(
      image: Image.asset(_spinners[index]).image,
    );
  }
}

class RotatingImage extends StatefulWidget {
  static const double kImageWidth = 100;
  static const double kImageHeight = 100;
  static const double kRotationPerTick = 6.3;

  RotatingImage({
    Key key,
    this.image,
  })  : assert(image != null),
        super(key: key);

  final ImageProvider<Object> image;

  @override
  _RotatingImageState createState() => _RotatingImageState();
}

class _RotatingImageState extends State<RotatingImage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: RotatingImage.kImageWidth,
        height: RotatingImage.kImageHeight,
        child: FittedBox(
          fit: BoxFit.contain,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (BuildContext context, Widget widget) {
              return Transform.rotate(
                angle:
                    _animationController.value * RotatingImage.kRotationPerTick,
                child: widget,
              );
            },
            child: CircleAvatar(
              backgroundImage: widget.image,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
