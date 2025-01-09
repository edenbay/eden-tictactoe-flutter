import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/main.dart';

import '../big_card.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var board = appState.gameBoard;
    var scheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(2.0),
          child: appState.getIconFromType(appState.turnType),
        ),
        Expanded(
          child: GridView.builder(
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
                  onTap: () => print('aj!'),
                  child: Container(
                    color: color,
                    child: Circle(),
                  ),
                  // BigCard(
                  //   key: Key('$index'),
                  // piece: piece),
                  // onTap: () {
                  //       appState.place(piece.position);
                  //     },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
