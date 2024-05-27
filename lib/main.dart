
import 'package:tic_tac_toe/Piece.dart';

import 'game.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'position.dart';




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

class MyHomePage extends State<NaviBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;

    switch (currentPageIndex) {
      case 0:
      page = GamePage();
      case 1:
      page = const Placeholder();
      default:
      throw UnimplementedError('no widget found for $currentPageIndex');
    }

    return Scaffold(
      body: Column(
        children: [

            Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: page,
            ),
          ),         
          NavigationBar(
              destinations: [
                const NavigationDestination(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                const NavigationDestination(
                  icon: Icon(Icons.favorite),
                  label: 'Favorites',
                ),
              ],
              selectedIndex: currentPageIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  currentPageIndex = index;
                });
                print('selected: $index');
                
              },
            ),
        ],
      ),
    );
  }
}

class GamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var board = appState.gameBoard;

    late IconData icon;

      icon = 
     Icons.favorite;



    //  IconData getIconFromType(PieceType type) {
    // switch (type) {
    //   case PieceType.circle:
    //     return Icons.circle;
    //   case PieceType.cross:
    //     return Icons.close;
    //   default:
    //     return Icons.abc;
    //}
  //}


      return Center(
        child: GridView.builder(
          gridDelegate: 
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 1),
          itemCount: board.length,
          itemBuilder: (BuildContext context, index) {
            var piece = board[index];                 
          return InkWell(          
            child:    
            BigCard(
              key: Key('${index}'),
             piece: piece),
             onTap: () {
                  appState.place(piece.position);
                },         
                
              );
          },                                
        )
    );

  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.piece
  });

  
final Piece piece;

  @override
  Widget build(BuildContext context) {
var theme = Theme.of(context);

var appState = context.watch<MyAppState>();

var style = theme.textTheme.displayMedium!.copyWith(
  color: theme.colorScheme.onPrimary,
);

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child:
           appState.getIconFromType(piece.getType()),
        ),

        );
  }
}



class MyAppState extends ChangeNotifier {

static Game _game = Game(3);

Icon getIconFromType(PieceType type) {
    switch (type) {
      case PieceType.circle:
        return Icon(Icons.circle);
      case PieceType.cross:
        return Icon(Icons.close);
      default:
        return Icon(null);
    }      
  }


var gameBoard = _game.getBoard();
  void place(int position) {
      var  success = _game.tryPlace(position);
      print(success);
      print(position);
      print(_game.turn);
      notifyListeners();   
    }
}


