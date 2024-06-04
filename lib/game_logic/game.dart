import 'dart:io';

import 'package:provider/provider.dart';
import 'package:tic_tac_toe/game_logic/position.dart';

import 'piece.dart';

import 'grid_checker.dart';

import 'piece_type.dart';

class Game {

  final List<Piece> _gameboard = [];
  final _gridChecker = GridChecker();

  PieceType turn = PieceType.cross;

  late Piece _currentPiece;

  late int rows;
  late int columns;
  late int length;
  late int _amountOfEmpties;

  List<PieceType> results = [];

  Game(int multiplier)
  {
    rows = multiplier;
    columns = multiplier;

    length = rows*columns;

    _amountOfEmpties = length;

    setupBoard();
  }

  /// Gets a list of all results.
  List<PieceType> getResults() => results;

  ///Gets the gameboard.
  List<Piece> getBoard() => _gameboard;


  /** Sets up the game board, sets all pieces to empty 
   *  and their gridPositions to the corresponding row and column.
   */
  void setupBoard() {
    for (int i = 0; i < length; i++) {
      _gameboard.add(Piece(PieceType.empty, i));
    }
  }  


  
  //updates the cell at position [x,x] to the correct type.
  bool tryPlace(int position) {
    _currentPiece =  _gameboard
          .elementAt(position);

    if (canPlace()) {
      _currentPiece.updatePiece(turn);
      if (!checkWin()) {
        changeTurn();
      }

      

      return true;
    }
    return false;
  }
  

  ///checks if the piece and the pressed location is empty, if true = canPlace
  bool canPlace() =>  
    _currentPiece.type == PieceType.empty;
  

  void changeTurn() {          
    turn = (turn == PieceType.circle) 
    ? PieceType.cross : PieceType.circle;    
  }
  
  bool checkWin() {

    _amountOfEmpties--;

    PieceType result;
    if (_amountOfEmpties < length - rows) {

      result = _gridChecker.retrieveWinner(_gameboard, rows); 

      if (result != PieceType.empty) {
        print("resetting");
        _resetGame(result);
        return true;
      }

      if (_amountOfEmpties == 0) {
        print ("no mas!");
        _resetGame(result);
        return true;
      }
      
    }
    return false;
  }


  void _resetGame(PieceType winningType) {

    //sleep(Duration(seconds: 1));

    _gameboard.forEach((_resetType));
    
    _amountOfEmpties = length;
    results.add(winningType);
    turn = PieceType.cross;
  }

  void _resetType(Piece piece) {
    piece.type = PieceType.empty;
  }

}
