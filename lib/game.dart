//import 'dart:nativewrappers/_internal/vm/lib/ffi_patch.dart';




import 'package:english_words/english_words.dart';
import 'package:tic_tac_toe/position.dart';

import 'Piece.dart';

class Game {

  final length = 9;
  final List<List<Piece>> _gridList = [];
  final List<Piece> _gameboard = [];

  PieceType turn = PieceType.cross;

  late Piece _currentPiece;
  late int _currentPosition;

  final hello = [[]];

  int rows = 1;
  int columns = 1;

  int crosses = 0;
  int circles = 0;

  List<bool> results = [];

  






  Game(int multiplier)
  {
    rows = multiplier;
    columns = multiplier;

    setupBoard();
  }







    void setupBoard() {
    for (int i = 0; i < length; i++) {
      _gameboard.add(Piece(PieceType.empty, i));
    }

    var index = 0;
    for (int i = 0; i < 3; i++) {
      List<Piece> pieces = [];      
      for (int j = 0; j < 3; j++)
      {          
          pieces.add(_gameboard[index]);

          pieces[j].setGridPosition(Position(i, j));
          index++;
      }
      _gridList.add(pieces);
    }
  }  



  List<bool> getResults() => results;

  List<Piece> getBoard() => _gameboard;
  

  // /// creates a list of empty pieces.
  // List<Piece>  createRow(int column) {
  //   List<Piece> pieces = [];

  //   for (int i = 0; i < rows; i++) {
  //     pieces.add(Piece(PieceType.empty, i));
  //   }
  //   return pieces;
  // }

  //updates the cell at position [x,x] to the correct type.
  bool tryPlace(int position) {
    _currentPiece =  _gameboard
          .elementAt(position);

    if (canPlace()) {
     _currentPiece.updatePiece(turn);

      checkCurrentAgainstGrid();
      changeTurn();

      return true;
    }
    return false;
  }

  bool _isNotEmpty(Piece piece) => piece.type != PieceType.empty; 

  bool canPlace() {    
    return _currentPiece.type == PieceType.empty;
  }

  void changeTurn() {
    
    int count = 0;
    for (var piece in _gameboard) {
      if (piece.type == PieceType.empty) {
        count++;
      }
    }

    if (count == 0 || _checkWin().$1 == true) {
      _endGame();
    }

    
      //_checkWin();
    

    if (turn == PieceType.circle) {
      turn = PieceType.cross;
      crosses++;
    } else {
      turn = PieceType.circle;
      circles++;
    }
  }
  
  void _endGame() {
    for (var piece in _gameboard) {
      piece.type = PieceType.empty;
    }
  }
//skapa en gridList, gå sedan igenom gridList och gameboard och jämför dem, skiljs något, ändra den: gridList[i,j] = _gameboard[index];
  (bool, PieceType) _checkWin() {

    var winningType = PieceType.empty;
    var hasWon = false;
    for (int row = 0; row < 3; row++) {
      int crossCount = 0;
      int circleCount = 0;
      for (int column = 0; column < 3; column++) {
        var piece =_gridList[row][column];
        switch (piece.type) {
          case PieceType.circle:
            circleCount++;
            break;
          case PieceType.cross:
            crossCount++;
            break;
          default:
            continue;
        }

        if (crossCount >= 3) {
        winningType = PieceType.cross;
        hasWon = true;
        results.add(true);
        break;
      }

      if (circleCount >= 3) {
        winningType = PieceType.circle;
        hasWon = true;
        results.add(false);
        break;
      }
      }
        
      
    }
      print('you have won: ${hasWon}, type is: ${winningType}');
      return (hasWon, winningType);
    }
  

    
    //hur for looparna ska gå
    //x
    //x
    //x

    //x x x

    //x
    //  x
    //    x
    
  

  void checkCurrentAgainstGrid() {
    print(retrieveFromGrid(_currentPiece).type);
    if (_currentPiece.type != retrieveFromGrid(_currentPiece).type) {
        updateInGrid(_currentPiece);
    }
  }

  Piece retrieveFromGrid(Piece piece) =>
    _gridList
    .elementAt(piece.gridPosition[0])
    .elementAt(piece.gridPosition[1]);

  void updateInGrid(Piece piece) {
    _gridList
    .elementAt(piece.gridPosition[0])
    .elementAt(piece.gridPosition[1])
    .type = piece.type;
  }
}

//0  0  0
//0  0  0
//0  0  0

//X  0  0
//0  X  0
//0  0  X

//X  0  O
//O  X  0
//O  0  X




enum Turn {
  circle,
  cross
}