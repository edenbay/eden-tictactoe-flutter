import 'package:flutter/material.dart';
import 'package:tic_tac_toe/components/shape.dart';

final class Circle extends Shape {
  const Circle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: CustomPaint(
        painter: CirclePainter(),
      ),
    );
  }
}

//Draws the actual circle
class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    //Center canvas
    canvas.translate(size.width / 2, size.height / 2);

    final center = [Offset.zero, Offset(0, 2), Offset(0, 4)];
    final radius = (size.width / 3.0);

    //Create circle paint
    final circle = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 6.5
      ..color = Colors.white;

    //Create shadow paint
    final shadow = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 6
      ..color = Color.fromRGBO(0, 0, 0, 0.25);

    //Create edge paint
    final edge = Paint()
      ..style = circle.style
      ..strokeWidth = size.width / 7
      ..color = Color.fromRGBO(186, 187, 187, 1);

    //Draw shadow
canvas.drawOval(Rect.fromLTRB(-40.5, -38, 42, 49), shadow);

    //Draw edge
    canvas.drawOval(Rect.fromLTRB(-40.5, -39.5, 41.5, 46), edge);

    //Draw circle
    canvas.drawOval(Rect.fromLTRB(-43, -43, 43, 43), circle);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
