import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/main.dart';

import '../components/line.dart';

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
            height: 70,
            width: 70,
            child: currentShape,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(64, 255, 255, 255)),
                  foregroundDecoration: BoxDecoration(
                    color: (appState.isGameOver)
                        ? const Color.fromARGB(100, 0, 0, 0)
                        : Colors.transparent,
                  ),
                  child: GridView.builder(
                    key: Key('grid'),
                    shrinkWrap: true,
                    padding: EdgeInsets.all(0),
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, crossAxisSpacing: 1),
                    itemCount: board.length,
                    itemBuilder: (BuildContext context, index) {
                      var piece = board[index];
                      Color color = (index % 2 == 0)
                          ? scheme.secondaryContainer
                          : scheme.primaryContainer;
                      return InkWell(
                        onTap: () => appState.place(piece.position),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color.fromARGB(255, 23, 43, 28),
                                      color
                                    ],
                                    stops: [
                                      0.02,
                                      0.05
                                    ]),
                                border: Border.all(
                                  color: Color(0xFFFFFFFF),
                                  width: 2.0,
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
                  ),
                ),
                // Container(color: Colors.amber,),
               WinLine()
              ],
            ),
          ),
        ),
      ],
    );
  }
}
