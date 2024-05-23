import 'dart:ffi';
import 'dart:nativewrappers/_internal/vm/lib/ffi_patch.dart';


import 'package:tictactoe/Piece.dart';

class Game {

  List<List<Piece>> _gameboard = [];

  PieceType turn = PieceType.cross;

  late Piece _currentPiece;

  int rows = 1;
  int columns = 1;

  Game(int multiplier)
  {
    this.rows = multiplier;
    this.columns = multiplier;

    _currentPiece = Piece(turn);

    setupBoard();
  }

  void setupBoard() {
    for (int column = 0; column < columns; column++) {
          _gameboard.add(createRow());
    }
  }

  /// creates a list of empty pieces.
  List<Piece>  createRow() {
    List<Piece> pieces = [];

    for (int i = 0; i < rows; i++) {
      pieces.add(Piece(PieceType.empty));
    }
    return pieces;
  }

  //updates the cell at position [x,x] to the correct type.
  void place(List<int> position) {
      if (canPlace()) {

        _gameboard
            .elementAt(position[0])
            .elementAt(position[1])
            .updatePiece(turn);

        changeTurn();
      }

  }


  bool canPlace() {

    return true;
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

class Position {
  int row = 0;
  int column = 0;

  public(int row, int column) {
    this.row = row;
    this.column = column;
  }
}

enum Turn {
  circle,
  cross
}