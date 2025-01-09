import 'package:flutter/material.dart';
import 'package:tic_tac_toe/components/shape.dart';

final class Cross extends Shape {
  const Cross({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment(0, 0),
      fit: StackFit.loose,
      children: [
        HalfCross(
          rotationDegrees: -45,
        ),
        HalfCross(
          rotationDegrees: 45,
        ),
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
  final double rotationDegrees;
  final bool useBorders;

  BoxShadow buildShadow(double xOffset) {
    return BoxShadow(
        color: Color.fromRGBO(0, 0, 0, .25),
        offset: Offset(xOffset, 4),
        blurStyle: BlurStyle.inner);
  }

  Border buildBorder(bool isRotatedRight, double width) {
    final borderSide = BorderSide(
      color: Color.fromRGBO(0, 0, 0, 0.25),
      width: width,
    );

    return (isRotatedRight)
        ? Border(
            bottom: borderSide,
            right: borderSide,
          )
        : Border(
            bottom: borderSide,
            left: borderSide,
          );
  }

  HalfCross({super.key, required this.rotationDegrees, this.useBorders = true});

  @override
  Widget build(BuildContext context) {
    const double threshold = 45.0;
    const double borderWidth = 2.5;
    final isRotatedRight = rotationDegrees >= threshold;

    final xOffset = isRotatedRight ? 4.0 : -4.0;
    final border =
        useBorders ? buildBorder(isRotatedRight, borderWidth) : Border();
    final width = useBorders ? 20.0 : 20.0 - borderWidth;
    final List<BoxShadow> shadows = useBorders ? [buildShadow(xOffset)] : [];

    return RotationTransition( //Duct-tape solution to rotating half-cross.
      turns: AlwaysStoppedAnimation(rotationDegrees / 360), //Keeps the angle static.
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          border: border,
          boxShadow: shadows,
        ),
      ),
    );
  }
}
