import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tic_tac_toe/components/shape.dart';
import 'package:simple_shadow/simple_shadow.dart';


final class Cross extends Shape {
  const Cross({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: SimpleShadow(
          opacity: 0.25,
          offset: Offset(0, 5),
          sigma: 0.5,
          child: SvgPicture.asset('lib/assets/images/cross.svg'),
        )
        );
  }
}
