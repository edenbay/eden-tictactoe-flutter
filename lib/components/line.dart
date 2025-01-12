import 'package:flutter/material.dart';
import 'dart:math' as math;

class WinLine extends StatelessWidget {
  const WinLine({super.key});

  @override
  Widget build(BuildContext context) {
    var key = context;
    print(key);
    return SizedBox(
      height: 395,
      width: 393,
      child: CustomPaint(
        painter: LinePainter(),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  late final double rotation;
  late final ({double x, double y}) offset;
  late final double length;
  //om first - last == 6 nedåt
  //om first - last == 2 höger
  //om first - last == 4 diagvän
  //om first - last == 8 diaghög

  //y 10.0 y -65.0 nedåt
  //x 30.0 y 0.0 diaghög
  //x 10.0 y 65.0 höger

  LinePainter({int first = 1, int last = 7}) {
    offset = (x: 0.0, y: 0.0);
  }

  void constructLine(int first, int last) {
    int difference = (first - last).abs();

    switch (difference) {
      case 6:
        offset = (x: 10.0, y: -65.0);
        rotation = math.pi / 2;
        // offset = (x: ,y: );
        // offset = (x: ,y: );
        // offset = (x: ,y: );
        break;
      case 2:
        offset = (x: 10.0, y: -65.0);
        rotation = 0;
      default:
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    double rotation = 0;//math.pi / 2;
    bool isDiag = (rotation.abs() == math.pi / 4);
    double length = isDiag ? 750.0 : 550.0;
    var paint = Paint()
      ..color = Color(0xFFFFFFFF)
      ..strokeWidth = 20.0;

    var edge = Paint()
      ..color = Color(0x25000000)
      ..strokeWidth = 2.0;

    var shadow = Paint.from(edge)..strokeWidth = 4.0;
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    rotate(canvas, centerX, centerY, rotation);

    //for cols: rotate(canvas, centerX, centerY, math.pi / 2);
    //canvas.translate(0, centerX-centerX-centerX/1.5); // for col/row 3
    //canvas.translate(0, centerX/1.5); // for col/row 1
    //canvas.translate(0, 0); // for col/row 2

    drawCentered(canvas, centerX, centerY, length, 0, paint);
    drawCentered(canvas, centerX, centerY, length, 9, edge);
    drawCentered(canvas, centerX, centerY, length, 12, shadow);
  }

  void drawCentered(Canvas canvas, double centerX, double centerY, double len,
      double offset, Paint paint) {
    canvas.drawLine(Offset((centerX) - len / 3, centerY + offset),
        Offset((centerX) + len / 3, centerY + offset), paint);
  }

  void rotate(Canvas canvas, double cx, double cy, double angle) {
    canvas.translate(cx, cy);
    canvas.rotate(angle);
    canvas.translate(-cx, -cy);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
