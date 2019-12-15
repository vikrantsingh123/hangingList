import 'dart:math';
import 'package:flutter/material.dart';

import 'animationCard.dart';

class HangingItem extends StatefulWidget {
  final Widget front, back;
  final bool moveListItem;
  double _height, _width;

  HangingItem(
      this.front, this.back, this.moveListItem, this._height, this._width);
  @override
  _HangingItemState createState() => _HangingItemState();
}

typedef void BoolCallback(bool isFront);

class _HangingItemState extends State<HangingItem>
    with TickerProviderStateMixin {
  AnimationController animationController;
  AnimationController _flipController;

  Animation<double> _frontScale;
  Animation<double> _backScale;

  Animation<double> animation;

  double _angle = 0;
  Offset _start, _end;
  bool startAnim = false, isFront = true;

  VoidCallback onFlip;
  BoolCallback onFlipDone;
  bool flipOnTouch;

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(duration: Duration(milliseconds: 1000), vsync: this)
          ..addListener(() {});
    _flipController = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _frontScale = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween(begin: 0.0, end: pi / 2)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(pi / 2),
          weight: 50.0,
        ),
      ],
    ).animate(_flipController);
    _backScale = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(pi / 2),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween(begin: -pi / 2, end: 0.0)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 50.0,
        ),
      ],
    ).animate(_flipController);
    _flipController.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        if (onFlipDone != null) onFlipDone(isFront);
      }
    });
  }

  void initialiseAnimationAngle() {
    animation = Tween(begin: _angle, end: 0.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.bounceOut,
    ))
      ..addListener(() {
        setState(() {});
      });
  }

  _startDrag(DragStartDetails details) {
    setState(() {
      _start = details.globalPosition;
    });
  }

  _updateDrag(DragUpdateDetails details) {
    _end = details.globalPosition;
    setState(() {
      _angle = atan2(_end.dy - _start.dy, _end.dx - _start.dx) * (180 / pi);
      var _angle1 = atan2(0 - _start.dy, 0);
      var _angle2 = atan2(0 - _end.dy, _start.dx - _end.dx);
      _angle = 3 * (_angle1 - _angle2);

      _angle = -_angle;
      // if (_angle < 0) {
      //   _angle = 0;
      // }
      // _angle = 1;
    });
  }

  _endDrag(DragEndDetails details) async {
    try {
      setState(() {
        startAnim = true;
      });
      initialiseAnimationAngle();

      animationController.forward(from: 0.0).orCancel.then((value) {
        setState(() {
          startAnim = false;
          _angle = 0;
        });
      });
    } on TickerCanceled {}
  }

  _openCard() {
    if (onFlip != null) {
      onFlip();
    }
    if (isFront) {
      _flipController.forward(from: 0.0).orCancel.then((onValue) {
        setState(() {
          isFront = !isFront;
        });
      });
    } else {
      _flipController.reverse().orCancel.then((onValue) {
        setState(() {
          isFront = !isFront;
        });
      });
    }
  }

  _navigateCard() {
    //Navigate to the screen
  }

  @override
  Widget build(BuildContext context) {
    double _animationAngle;
    if (widget.moveListItem) {
      if (startAnim) {
        _animationAngle = animation.value;
      } else {
        _animationAngle = _angle;
      }
    }

    return Center(
      child: GestureDetector(
          //You can add your own gestures and their functionalites
          onHorizontalDragStart: widget.moveListItem ? _startDrag : null,
          onHorizontalDragUpdate: widget.moveListItem ? _updateDrag : null,
          onHorizontalDragEnd: widget.moveListItem ? _endDrag : null,
          onTap: _openCard,
          onDoubleTap: _navigateCard,
          child: Stack(
            fit: StackFit.passthrough,
            children: <Widget>[
              _buildContent(
                  isUpSide: true,
                  animationAngle: widget.moveListItem ? _animationAngle : 0),
              _buildContent(
                  isUpSide: false,
                  animationAngle: widget.moveListItem ? _animationAngle : 0)
            ],
          )),
    );
  }

  Widget _buildContent({@required bool isUpSide, double animationAngle}) {
    return IgnorePointer(
      ignoring: isUpSide ? !isFront : isFront,
      child: AnimationCard(
          animation: isUpSide ? _frontScale : _backScale,
          hangingObject: isUpSide ? widget.front : widget.back,
          height: widget._height,
          width: widget._width,
          animationAngle: animationAngle,
          isUpside: isUpSide),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    _flipController.dispose();
    super.dispose();
  }
}
