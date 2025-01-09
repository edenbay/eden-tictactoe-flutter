import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/components/cross.dart';
import 'package:tic_tac_toe/main.dart';

import '../big_card.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var board = appState.gameBoard;
    var scheme = Theme.of(context).colorScheme;

    var currentShape = Transform.scale(
      scale: 0.5,
      origin: Offset(0, 0),
      child: appState.getShapeByType(appState.turnType),
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SafeArea(
          child: SizedBox(
            height: 50,
            width: 50,
            child: currentShape,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 1),
              itemCount: board.length,
              itemBuilder: (BuildContext context, index) {
                var piece = board[index];
                Color color = (index % 2 == 0)
                    ? scheme.secondaryContainer
                    : scheme.primaryContainer;
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: InkWell(
                    onTap: () => appState.place(piece.position),
                    child: Container(
                      color: color,
                      child: appState.getShapeByType(piece.type),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
