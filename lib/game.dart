import 'package:provider/provider.dart';
import 'package:tic_tac_toe/position.dart';

import 'piece.dart';

import 'grid_checker.dart';

import 'piece_type.dart';

class Game {

  final List<List<Piece>> _gridBoard = [];
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

    var index = 0;
    for (int i = 0; i < 3; i++) {
      List<Piece> pieces = [];      
      for (int j = 0; j < 3; j++)
      {          
          pieces.add(_gameboard[index]);

          pieces[j].setGridPosition(Position(i, j));
          index++;
      }
      _gridBoard.add(pieces);
    }
  }  


  
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

  ///checks if the piece and the pressed location is empty, if true = canPlace
  bool canPlace() =>  
    _currentPiece.type == PieceType.empty;
  

  void changeTurn() {
            
    _amountOfEmpties--;
    
    PieceType test;
    if (_amountOfEmpties < length - rows) {
      test = _gridChecker.retrieveWinner(_gameboard, rows); 
    }

    if (_amountOfEmpties == 0 || _checkWin() != PieceType.empty) {
      _resetGame();
    }
    
      //_checkWin();
    
    turn = (turn == PieceType.circle) 
    ? PieceType.cross : PieceType.circle;
    
  }
  

  void _resetGame() {
    _gameboard.forEach((_resetType));
    
    _amountOfEmpties = length;
  }

  void _resetType(Piece piece) {
    piece.type = PieceType.empty;
  }

  ///skapa en gridList, gå sedan igenom gridList och gameboard och jämför dem, skiljs något, ändra den: gridList[i,j] = _gameboard[index];
  PieceType _checkWin() {

    var winningType = PieceType.empty;
    var hasWon = false;
    for (int row = 0; row < 3; row++) {
      int crossCount = 0;
      int circleCount = 0;
      for (int column = 0; column < 3; column++) {
        var piece =_gridBoard[row][column];
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
        break;
      }

      if (circleCount >= 3) {
        winningType = PieceType.circle;
        hasWon = true;
        break;
      }
      }
        
      
    }

    for (int column = 0; column < 3; column++) {
      int crossCount = 0;
      int circleCount = 0;
      for (int row = 0; row < 3; row++) {
        var piece =_gridBoard[row][column];
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
        break;
      }

      if (circleCount >= 3) {
        winningType = PieceType.circle;
        hasWon = true;
        break;
      }
      }
        
      
    }
    int crossCount = 0;
    int circleCount = 0;
    for (int column = 0; column < 3; column++) {
      
      var row = column;
        var piece =_gridBoard[row][column];
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
        break;
      }

      if (circleCount >= 3) {
        winningType = PieceType.circle;
        hasWon = true;
        break;
      
      }
        
      
    }

    crossCount = 0;
    circleCount = 0;
    var row = 0;
    for (int column = 2; column >= 0; column--) {
      
      
        var piece =_gridBoard[row][column];
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
        row++;

        if (crossCount >= 3) {
        winningType = PieceType.cross;
        hasWon = true;    
        break;
      }

      if (circleCount >= 3) {
        winningType = PieceType.circle;
        hasWon = true;    
        break;
      
      }
              
    }

      if (hasWon) {
        results.add(winningType);
      }
      
      print('you have won: $hasWon, type is: $winningType');
      return (winningType);
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
    _gridBoard
    .elementAt(piece.gridPosition[0])
    .elementAt(piece.gridPosition[1]);

  void updateInGrid(Piece piece) {
    _gridBoard
    .elementAt(piece.gridPosition[0])
    .elementAt(piece.gridPosition[1])
    .type = piece.type;
  }
}
