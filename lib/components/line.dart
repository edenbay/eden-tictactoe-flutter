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

enum _Direction { down, right, diagLeft, diagRight }

enum _Place { first, second, last }

class LinePainter extends CustomPainter {
  late final double rotation;
  late final double length;
  late final _Direction _direction;
  late final _Place? _place;
  late final int first;
  //om first - last == 6 nedåt
  //om first - last == 2 höger
  //om first - last == 4 diagvän
  //om first - last == 8 diaghög

  LinePainter({int first = 2, int last = 6}) {
    this.first = first;
    constructLine(first, last);
    setPlacement();
  }

  void constructLine(int first, int last) {
    _direction = _getDirection(first, last);
    switch (_direction) {
      case _Direction.down:
        rotation = math.pi / 2; //90*
        break;
      case _Direction.right:
        rotation = 0; //0*
        break;
      case _Direction.diagLeft:
        rotation = math.pi / -4; //-45*
        break;
      case _Direction.diagRight:
        rotation = math.pi / 4; //45*
        break;
    }
  }

  void setPlacement() {
    switch (first) {
      case 0:
        if (_direction == _Direction.right) _place = _Place.first;
        if (_direction == _Direction.down) _place = _Place.last;

        break;
      case 1:
        if (_direction == _Direction.down) _place = _Place.second;
        break;
      case 2:
        if (_direction == _Direction.down) _place = _Place.first;
      case 3:
        if (_direction == _Direction.right) _place = _Place.second;
        break;
      case 6:
        if (_direction == _Direction.right) _place = _Place.last;
        break;
      default:
        _place = null;
    }
  }

  _Direction _getDirection(int first, int last) {
    int difference = (first - last).abs();

    switch (difference) {
      case 6:
        return _Direction.down;
      case 2:
        return _Direction.right;
      case 4:
        return _Direction.diagLeft;
      case 8:
        return _Direction.diagRight;
    }
    throw Error.safeToString(
        'No value corresponding with $difference found for $_Direction');
  }

  @override
  void paint(Canvas canvas, Size size) {
    bool shouldRotate = (_direction != _Direction.right);

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

    if (shouldRotate) {
      rotate(canvas, centerX, centerY, rotation);
    }
    if (!isDiag) {
      handlePlacement(shouldRotate, canvas, centerX);
    }

    drawCentered(canvas, centerX, centerY, length, 0, paint); // line
    drawCentered(canvas, centerX, centerY, length, 9, edge); // edge
    drawCentered(canvas, centerX, centerY, length, 12, shadow); // shadow
  }

  void handlePlacement(bool shouldRotate, Canvas canvas, double centerX) {
    if (_place == null) { 
      return;
    }

    bool isFirstPlace = shouldRotate && _place == _Place.first ||
        !shouldRotate && _place == _Place.first;

    bool isLastPlace = shouldRotate && _place == _Place.last ||
        !shouldRotate && _place == _Place.last;

    if (isFirstPlace) {
      canvas.translate(0, centerX - centerX - centerX / 1.5);
    }
    if (isLastPlace) {
      canvas.translate(0, centerX / 1.5);
    }
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
