//import 'dart:nativewrappers/_internal/vm/lib/ffi_patch.dart';


import 'package:tictactoe/Piece.dart';
import 'package:tictactoe/position.dart';

class Game {

  final List<List<Piece>> _gameboard = [];

  PieceType turn = PieceType.cross;

  late Piece _currentPiece;
  late List<int> _currentPosition;

  int rows = 1;
  int columns = 1;

  Game(int multiplier)
  {
    rows = multiplier;
    columns = multiplier;

    //_currentPiece = Piece(turn);

    setupBoard();
  }

  void setupBoard() {
    for (int column = 0; column < columns; column++) {
      _gameboard.add(createRow(column));
    }
  }

  List<List<Piece>> getBoard() {
    return _gameboard;
  }

  /// creates a list of empty pieces.
  List<Piece>  createRow(int column) {
    List<Piece> pieces = [];

    for (int i = 0; i < rows; i++) {
      pieces.add(Piece(PieceType.empty, Position(i,column)));
    }
    return pieces;
  }

  //updates the cell at position [x,x] to the correct type.
  bool tryPlace(List<int> position) {
    _currentPiece =  _gameboard
          .elementAt(_currentPosition[0])
          .elementAt(_currentPosition[1]);

    if (canPlace()) {
     _currentPiece.updatePiece(turn);

      changeTurn();

      return true;
    }
    return false;
  }


  bool canPlace() {    
    return _currentPiece.type != PieceType.empty;
  }

  void changeTurn() {
    if (turn == PieceType.circle) {
      turn = PieceType.cross;
    } else {
      turn = PieceType.circle;
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
}



enum Turn {
  circle,
  cross
}