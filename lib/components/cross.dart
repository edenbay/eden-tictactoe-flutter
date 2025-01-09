import 'package:flutter/material.dart';
import 'package:tic_tac_toe/components/shape.dart';
import 'dart:math' as math;

final class Cross extends Shape {
  const Cross({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment(0, 0),
      fit: StackFit.loose,
      children: [
        HalfCross(
          isRotatedRight: false,
        ),
        HalfCross(
          isRotatedRight: true,
        ),
        //Used to cover the shadowed cross-section
        RotationTransition(
          turns: AlwaysStoppedAnimation(-45 / 360),
          child: Padding(
            padding: const EdgeInsets.only(left: 2.6, bottom: 2.5),
            child: Container(
              width: 18.0,
              height: 115,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class HalfCross extends StatelessWidget {
  final bool useBorders;
  final bool isRotatedRight;

  BoxShadow buildShadow(double xOffset) {
    return BoxShadow(
        color: Color.fromRGBO(0, 0, 0, .25),
        offset: Offset(xOffset, 4),
        blurStyle: BlurStyle.inner);
  }

  Border buildBorder(double width) {
    final borderSide = BorderSide(
      color: Color.fromRGBO(0, 0, 0, 0.25),
      width: width,
    );

    return Border(
      bottom: borderSide,
      right: borderSide,
    );
  }

  HalfCross({super.key, this.isRotatedRight = true, this.useBorders = true});

  @override
  Widget build(BuildContext context) {
    const double borderWidth = 2.5;
    const fortyFiveDegrees = math.pi / 4;
    const xOffset = 4.0;
    final border = useBorders ? buildBorder(borderWidth) : Border();
    final width = useBorders ? 20.0 : 20.0 - borderWidth;
    final List<BoxShadow> shadows = useBorders ? [buildShadow(xOffset)] : [];

    return Transform.flip(
      flipX: !isRotatedRight,
      child: Transform.rotate(
        angle: fortyFiveDegrees,
        child: Container(
          width: width,
          decoration: BoxDecoration(
            color: Colors.white,
            border: border,
            boxShadow: shadows,
          ),
        ),
      ),
    );
  }
}
