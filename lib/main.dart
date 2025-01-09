import 'dart:math';

import 'game_logic/piece.dart';
import 'game_logic/game.dart';
import 'game_logic/piece_type.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/my_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tic Tac Toe',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Color.fromRGBO(119, 129, 122, 1),
              primaryContainer: Color.fromARGB(119, 129, 122, 1)),
        ),
        home: const NaviBar(),
      ),
    );
  }
}

class NaviBar extends StatefulWidget {
  const NaviBar({super.key});

  @override
  State<NaviBar> createState() => MyHomePage();
}

class MyAppState extends ChangeNotifier {
  static final Game _game = Game(3);
  List<Piece> gameBoard = _game.getBoard();
  List<PieceType> results = _game.getResults();
  var turnType = _game.turn;

  Icon getIconFromType(PieceType type) {
    const double size = 75.0;

    switch (type) {
      case PieceType.circle:
        return const Icon(Icons.circle, size: size);
      case PieceType.cross:
        return const Icon(Icons.close, size: size);
      default:
        return const Icon(null);
    }
  }

  void place(int position) {
    var canPlace = _game.tryPlace(position);

    turnType = _game.turn;
    notifyListeners();
  }

  String fetchResult(int index) {
    String win = 'Win';
    String loss = 'Loss';

    String cross = loss;
    String circle = loss;

    var winType = results[index];

    switch (winType) {
      case PieceType.empty:
        break;
      case PieceType.circle:
        circle = win;
        break;
      case PieceType.cross:
        cross = win;
        break;
    }

    return 'Cross: $cross | Circle: $circle';
  }
}

class Cross extends StatelessWidget {
  const Cross({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.deepPurpleAccent),
          ],
        ),
        child: Stack(
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
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
          ],
        ),
      ),
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

    return RotationTransition(
      turns: AlwaysStoppedAnimation(rotationDegrees / 360),
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          border: border,
          boxShadow: shadows,
        ),
      ),
    );
  }
}

class Circle extends StatelessWidget {
  const Circle({super.key});

  @override
  Widget build(BuildContext context) {
    Color tileColor = Theme.of(context).colorScheme.primaryContainer;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        alignment: AlignmentDirectional(0, 0),
        fit: StackFit.expand,
        children: [
          //White circle
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border(
                bottom: BorderSide(
                  color: const Color.fromARGB(43, 0, 0, 0),
                  strokeAlign: BorderSide.strokeAlignInside,
                  width: 2,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4),
                  color: const Color.fromRGBO(0, 0, 0, 0.25),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(22.0),
            child: Container(
              decoration: BoxDecoration(
                color: tileColor,
                shape: BoxShape.circle,
                border: Border(
                  top: BorderSide(
                    color: const Color.fromARGB(43, 0, 0, 0),
                    strokeAlign: BorderSide.strokeAlignOutside,
                    width: 2,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset.zero, 60, Paint());
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
