import 'package:flutter/material.dart';

class HangTransform extends StatelessWidget {
  final Matrix4 transform;
  final double _height, _width, _animationAngle;
  final Widget _widget;
  final bool isUpside;
  HangTransform(this.transform, this._height, this._width, this._animationAngle,
      this._widget, this.isUpside);

  @override
  Widget build(BuildContext context) {
    return Transform(
        transform: transform,
        child: Container(
            height: _height,
            width: _width,
            child: Transform.rotate(
                angle: _animationAngle,
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 20.0,
                            offset: Offset(20.0, 20.0))
                      ],
                      gradient: LinearGradient(
                        colors: [Color(0xfffff9c4), Color(0xfffffde7)],
                        begin: FractionalOffset(1.0, 1.0),
                        end: FractionalOffset(1.7, 0.0),
                        stops: [0.0, 1.0],
                      ),
                    ),
                    child: _widget))));
  }
}
