import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tictactoe/Piece.dart';

import 'package:tictactoe/game.dart';
import 'package:tictactoe/position.dart';


late Game game;
int multiplier = 3;

void main() {
  runApp(const MyApp());
  game = Game(multiplier);
}
typedef MyBuilder = void Function(BuildContext context, void Function() methodFromChild);
var activatedColor =  Color.fromARGB(255, 167, 44, 44);

late void Function() myMethod;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
        itemCount: 9,
        gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemBuilder: (context, index) {
          return Padding(
          padding: const EdgeInsets.all(4.0),
          child:
          GestureDetector(
            onTap: () {
              myMethod.call();
            },
            child:
             Tile(key: key)             
          )                         
          );
    }
      ),
    )
    );
  }
}

class Tile extends StatefulWidget {
  final MyBuilder builder;
  late int id;
  late Position position;

  late Icon icon = Icon(Icons.emoji_people);
  
  Tile ({Key? key, required this.builder}) : super(key: key);

   @override
   State<Tile> createState() => _TileState();

  //Tile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      child: this.icon
      );
  }

  void setIcon() {
      if (game.turn == PieceType.circle) {
        icon = const Icon(Icons.circle_outlined, size: 50,);
      }
      else {
        icon = const Icon(Icons.close, size: 100.0,);
      }
  }
}