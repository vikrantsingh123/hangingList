import 'package:flutter/material.dart';
import 'hangTransform.dart';

class AnimationCard extends StatelessWidget {
  final Widget hangingObject;
  final Animation<double> animation;
  final double height, width, animationAngle;
  final bool isUpside;
  AnimationCard(
      {this.animation,
      this.hangingObject,
      this.height,
      this.width,
      this.animationAngle,
      this.isUpside});
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget child) {
        final Matrix4 transform = new Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(animation.value);

        return HangTransform(
            transform, height, width, animationAngle, hangingObject, isUpside);
      },
    );
  }
}
