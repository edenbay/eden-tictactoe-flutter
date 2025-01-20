import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/game_logic/piece.dart';
import 'package:tic_tac_toe/main.dart';

import '../components/line.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var board = appState.gameBoard;
    var scheme = Theme.of(context).colorScheme;
    bool isWin = appState.isWin;

    var currentShape = Transform.scale(
      scale: 0.75,
      origin: Offset.zero,
      child: appState.getShapeByType(appState.turnType),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SafeArea(
          child: SizedBox(
            height: 70,
            width: 70,
            child: currentShape,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              var length = constraints.maxWidth;
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(color: Color(0xffffffff)),
                    foregroundDecoration: BoxDecoration(
                      color: (appState.isGameOver)
                          ? const Color.fromARGB(100, 0, 0, 0)
                          : Colors.transparent,
                    ),
                    child: GameGrid(
                        board: board, scheme: scheme, appState: appState),
                  ),
                  SizedBox(
                    width: length,
                    height: length,
                    child:
                        WinLine(isWin: isWin, points: appState.result.indices),
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class GameGrid extends StatelessWidget {
  const GameGrid({
    super.key,
    required this.board,
    required this.scheme,
    required this.appState,
  });

  final List<Piece> board;
  final ColorScheme scheme;
  final MyAppState appState;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      key: Key('grid'),
      shrinkWrap: true,
      padding: EdgeInsets.all(0),
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 1),
      itemCount: board.length,
      itemBuilder: (BuildContext context, index) {
        var piece = board[index];
        Color color = (index % 2 == 0)
            ? scheme.secondaryContainer
            : scheme.primaryContainer;
        return InkWell(
          onTap: () {
            if (!appState.isGameOver) {
              appState.place(piece.position);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color.fromARGB(255, 23, 43, 28), color],
                      stops: [0.02, 0.05]),
                  border: Border.all(
                    color: Color.fromARGB(255, 170, 170, 170),
                    width: 2.5,
                  ),
                ),
                child: Stack(
                  children: [
                    appState.getShapeByType(piece.type),
                    Text('$index')
                  ],
                )),
          ),
        );
      },
    );
  }
}
