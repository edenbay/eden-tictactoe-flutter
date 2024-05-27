//import 'dart:nativewrappers/_internal/vm/lib/ffi_patch.dart';



import 'package:tic_tac_toe/position.dart';

import 'Piece.dart';

class Game {

  final length = 9;
  //final List<List<Piece>> _gameboard = [];
  final List<Piece> _gameboard = [];

  PieceType turn = PieceType.cross;

  late Piece _currentPiece;
  late int _currentPosition;

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
    for (int i = 0; i < length; i++) {
      _gameboard.add(Piece(PieceType.empty, i));
    }
  }
  // void setupBoard() {
  //   for (int column = 0; column < columns; column++) {
  //     _gameboard.add(createRow(column));
  //   }
  // }

  List<Piece> getBoard() {
    return _gameboard;
  }

  /// creates a list of empty pieces.
  List<Piece>  createRow(int column) {
    List<Piece> pieces = [];

    for (int i = 0; i < rows; i++) {
      pieces.add(Piece(PieceType.empty, i));
    }
    return pieces;
  }

  //updates the cell at position [x,x] to the correct type.
  bool tryPlace(int position) {
    _currentPiece =  _gameboard
          .elementAt(position);

    if (canPlace()) {
     _currentPiece.updatePiece(turn);

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

    if (count == 0) {
      _endGame();
    }

    if (turn == PieceType.circle) {
      turn = PieceType.cross;
    } else {
      turn = PieceType.circle;
    }
  }
  
  void _endGame() {
    for (var piece in _gameboard) {
      piece.type = PieceType.empty;
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