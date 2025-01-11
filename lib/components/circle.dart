import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:tic_tac_toe/components/shape.dart';

final class Circle extends Shape {
  const Circle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: SimpleShadow(
          opacity: 0.25,
          offset: Offset(0, 5),
          sigma: 0.5,
          child: SvgPicture.asset('lib/assets/images/circle.svg'),
        )
        );
  }
}


