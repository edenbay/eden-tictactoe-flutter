
import 'package:tic_tac_toe/piece.dart';

import 'game.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';





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
      page = const GamePage();
      case 1:
      page = const StatisticsPage();
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
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.gamepad),
                  label: 'Tic Tac Toe',
                ),
                NavigationDestination(
                  icon: Icon(Icons.wysiwyg),
                  label: 'Statistics',
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
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var board = appState.gameBoard;


    return 
          Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: <Widget> [
              Expanded(
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
                          key: Key('$index'),
                        piece: piece),
                        onTap: () {
                              appState.place(piece.position);
                            },           
                          );
                      },                                
                    ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child:  Text('hello'),
                ),                
            ],                              
    );
    }
      
}

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var results = appState.results;

      return SafeArea(
        child:
          ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: results.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 50,
                color: Colors.amber,
                child: Center(child: Text(appState.fetchResult(index))),
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

static final Game _game = Game(3);

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


List<Piece> gameBoard = _game.getBoard();
List<PieceType> results = _game.getResults();

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


