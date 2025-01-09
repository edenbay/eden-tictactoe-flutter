import 'dart:math';

import 'package:tic_tac_toe/components/circle.dart';
import 'package:tic_tac_toe/components/cross.dart';
import 'package:tic_tac_toe/components/shape.dart';

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
              primaryContainer: Color.fromARGB(255, 76, 89, 79),
              secondaryContainer: Color.fromARGB(255, 119, 129, 122),
              surfaceContainerLowest: Color.fromARGB(255, 28, 31, 34)),
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

  @Deprecated('Use getShapeByType() instead.')
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

  Shape getShapeByType(PieceType type) {
    switch (type) {
      case PieceType.circle:
        return Circle();
      case PieceType.cross:
        return Cross();
      default:
        return Shape();
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
