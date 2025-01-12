import 'package:tic_tac_toe/components/circle.dart';
import 'package:tic_tac_toe/components/cross.dart';
import 'package:tic_tac_toe/components/shape.dart';

import 'game_logic/enums/outcome.dart';
import 'game_logic/piece.dart';
import 'game_logic/game.dart';
import 'game_logic/enums/piece_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game_logic/result.dart';
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
                surfaceContainerLow: Color.fromARGB(255, 33, 37, 41),
                surfaceContainerLowest: Color.fromARGB(255, 28, 31, 34)),
            textTheme: TextTheme(
                titleSmall:
                    TextStyle(color: Color.fromARGB(255, 248, 249, 250)))),
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
  List<Outcome> results = _game.getResults();
  late Result result;
  late bool isGameOver = false;
  late bool isWin = false;
  var turnType = _game.turn;

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
    print(canPlace);
    if (canPlace != Outcome.none) {
      Future.delayed(Duration(milliseconds: 1500), () {
        //show graphic
        print('resetting');
        _game.resetGame();
      }).whenComplete(callNextRound);
    } //needs two callNextRound calls otherwise it updates wrong.

    callNextRound();
  }

  void callNextRound() {
    turnType = _game.turn;
    result = _game.result;
    isGameOver = result.isGameOver;
    isWin = result.isWin;
    notifyListeners();
  }

  String fetchResult(int index) {
    String win = 'Win';
    String loss = 'Loss';

    String cross = loss, circle = loss;

    Outcome winType = results[index];

    switch (winType) {
      case Outcome.circle:
        circle = win;
      case Outcome.cross:
        cross = win;
      default:
        break;
    }

    return 'Cross: $cross | Circle: $circle';
  }
}
