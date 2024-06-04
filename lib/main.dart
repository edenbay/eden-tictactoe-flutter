
import 'package:tic_tac_toe/piece.dart';

import 'game.dart';
import 'piece_type.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'my_home_page.dart';





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
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
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
      var success = _game.tryPlace(position);
      print(success);
      print(position);
      print(_game.turn);
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


