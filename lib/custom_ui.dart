import 'dart:math' as math;
import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    final Paint paint = Paint()..color = Colors.amberAccent;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      math.pi,
      math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }

  Widget paintProvider(){
    return Stack(
      fit: StackFit.passthrough,
      children: <Widget>[
        Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
              child: Container(
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20.0,
              child: Container(
                color: Colors.amberAccent,
              ),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Center(
              child: CustomPaint(
                painter: MyPainter(),
                size: const Size(50, 50),
              ),
            ),
          ],
        ),

      ],
    );
  }
}
