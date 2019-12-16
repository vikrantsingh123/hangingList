library hanginglist;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math';

import 'package:hanginglist/widgets/hangingItem.dart';

class HangingList<T> extends StatefulWidget {
  final List list;
  final Widget Function<T>(T) frontSide;
  final Widget Function<T>(T) backSide;
  final bool moveList, moveListItem;
  final double height, width;

  HangingList({
    @required this.list,
    @required this.frontSide,
    @required this.backSide,
    @required this.moveList,
    @required this.moveListItem,
    @required this.height,
    @required this.width,
  });
  @override
  _HangingListState createState() => _HangingListState();
}

class _HangingListState extends State<HangingList>
    with SingleTickerProviderStateMixin {
  double _angle = 0;
  AnimationController animationController;
  Animation<double> animation;

  PageController _pageController;
  bool endAnim = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController()
      ..addListener(() {
        setState(() {});
      });

    animationController =
        AnimationController(duration: Duration(milliseconds: 1500), vsync: this)
          ..addListener(() {});
  }

  initialiseAngle(bool left) {
    double angle = pi / 16;
    if (left == true) {
      angle = -angle;
    }
    animation = Tween(begin: angle, end: 0.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.bounceOut,
    ))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: widget.moveList
          ? (notification) {
              if (notification is ScrollStartNotification) {
              } else if (notification is ScrollUpdateNotification) {
                if (_pageController.position.userScrollDirection ==
                    ScrollDirection.forward) {
                  _angle = pi / 16;
                } else {
                  _angle = -pi / 16;
                }
              } else if (notification is ScrollEndNotification) {
                try {
                  endAnim = true;

                  if (_pageController.position.userScrollDirection ==
                      ScrollDirection.forward) {
                    initialiseAngle(true);
                  } else {
                    initialiseAngle(false);
                  }
                  animationController
                      .forward(from: 0.0)
                      .orCancel
                      .then((onValue) {
                    _angle = 0;
                    endAnim = false;
                  });
                } on TickerCanceled {}
              }
              return false;
            }
          : null,
      child: PageView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.list.length,
          controller: widget.moveList ? _pageController : null,
          itemBuilder: (context, index) {
            if (endAnim) {
              _angle = animation.value;
            } else {
              _angle = _angle;
            }
            return Transform.rotate(
                angle: widget.moveList ? _angle : 0,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(60, 20, 60, 20),
                    child: HangingItem(
                        widget.frontSide(widget.list[index]),
                        widget.backSide(widget.list[index]),
                        widget.moveListItem,
                        widget.height,
                        widget.width)));
          }),
    );
    // )
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
