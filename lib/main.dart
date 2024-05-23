import 'package:flutter/material.dart';

import 'package:tictactoe/game.dart';

import 'Piece.dart';

late Game game;
int multiplier = 3;

void main() {
  runApp(const MyApp());
  game = new Game(multiplier);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
        itemCount: 9,
        gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemBuilder: (context, index) {
          return Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Container(
              height: 50,
              width: 50,
              color: Colors.black,

              ),
          );

    }

      ),
    )
    );
  }
}
