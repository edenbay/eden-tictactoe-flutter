import 'dart:math';

import 'direction.dart';
import 'position.dart';

import 'piece.dart';

class GridChecker {

  //Gör globala piece, globala board.
  static late List<List<Piece>> _gameBoard;
  static late Piece _piece;
  static late List<PieceType> results = [];

  static List<Position> get(List<List<Piece>> board)
  {
      late List<Position> moveset = [];

      setGlobals(board);
      
      moveset = getMoveset(_piece);

      return moveset;
  }       

  static void setGlobals(List<List<Piece>> board)
  {
      _gameBoard = board;
      _piece = _gameBoard[0][0];
  }

  static List<Position> getMoveset(Piece piece)
  {
    late List<Position> moveset = [];

    var diagonals = Direction.getDiagonals();

      for (Direction direction in diagonals)
      {
          diagonal(direction)
                  .forEach((position) => moveset.add(position));
      }
  
    var straights = Direction.getStraights();

      for (Direction direction in straights)
      {
          straight(direction)
                  .forEach((position) => moveset.add(position));
      }
                 

      return moveset;
  }




  PieceType _checkWin() {

    var winningType = PieceType.empty;
    var hasWon = false;



    //0 0 0
    for (int row = 0; row < 3; row++) {
      int crossCount = 0;
      int circleCount = 0;
      for (int column = 0; column < 3; column++) {
        var piece =_gameBoard[row][column];
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
    //0
    //0
    //0
    for (int column = 0; column < 3; column++) {
      int crossCount = 0;
      int circleCount = 0;
      for (int row = 0; row < 3; row++) {
        var piece =_gameBoard[row][column];
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


    //0
    //  0
    //    0
    int crossCount = 0;
    int circleCount = 0;
    for (int column = 0; column < 3; column++) {
      
      var row = column;
        var piece =_gameBoard[row][column];
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

    //    0
    //  0
    //0
    crossCount = 0;
    circleCount = 0;
    var row = 0;
    for (int column = 2; column >= 0; column--) {
      
      
        var piece =_gameBoard[row][column];
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

  /// <summary>
  /// Gets all possible diagonal moves for the piece with the specified direction.
  /// </summary>
  /// <param name="piece"></param>
  /// <param name="board"></param>
  /// <param name="direction"></param>
  /// <returns>A list of all possible diagonal moves for the specified direction</returns>
  static List<Position> diagonal(Direction direction)
  {
      //creates temporary moveset list
      late List<Position> moveset = [];

      //saves the origin position.
      var origo = Position(_piece.gridPosition[0], _piece.gridPosition[1]);

      //saves the directional offsets.
      int rowOffset = direction.rowOffset;
      int columnOffset = direction.columnOffset;

      //saves the square root of the board's length as a "constant"
      int upperbound = sqrt(_gameBoard.length) as int;

      //sets the value to the upperbound if rowOffset is greater than 0, 0 if not.
      int comparingValue = (rowOffset > 0)
                        ? upperbound
                        : 0;

      //initializes the column
      var column = -1;

      for (int row = origo.row; diagonalIteration(row, comparingValue); row += rowOffset)
      {
          //checks if the column's value is less than 0 and sets its initial value.
          if (column < 0) {
              column = origo.column;
          }

          var position = Position(row, column);

          if (outOfBounds(position, upperbound, direction)) {
            break;
          }
              
          (bool, Position) isnull = isNull(position, direction, position);

          if (isnull.$1)
          {
              position = isnull.$2;
              moveset.add(position);
              column += columnOffset;
          }
          else {
              break;
          }
      }

      return moveset;
  }

    bool checkStraights(PieceType thisType, Direction direction) {
      
      //kolla hellre detta i överordnade metoden.
      var winningType = PieceType.empty;


      bool hasWon = false;  
      
      //kan välja vilken piecetype som ska kollas
      //eftersom båda kollar samma typ av värde

      for (int row = 0; row < 3; row++) {
      int typeCount = 0;

      for (int column = 0; column < 3; column++) {
        var piece =_gameBoard[row][column];
        
          if (piece.type == thisType) {
            typeCount++;
          }
        }

        if (typeCount >= 3) {
        winningType = thisType;
        hasWon = true;
        break;
      }

      
      }
        
      return hasWon;
    }
  

  
  /// <summary>
  /// Gets all possible straight moves for the piece with the specified direction.
  /// </summary>
  /// <param name="piece"></param>
  /// <param name="board"></param>
  /// <param name="direction"></param>
  /// <returns>A list of all possible straight moves for the specified direction</returns>
  static List<Position> straight(Direction direction)
  {
      //creates temporary moveset list
      late List<Position> moveset = [];

      //saves the origin position.
      var origo = Position(_piece.gridPosition[0], _piece.gridPosition[1]);

      //saves the directional offsets.
      (int left, int right) offset = (direction.rowOffset, direction.columnOffset);

      //splits up the origin row and column.
      (int left, int right) coord = (origo.row, origo.column);

      int startvalue = coord.$1;
      int row = coord.$1;
      int column = coord.$2;

      //swaps out the tuple values if the direction does not affect rows.

      bool isRow = isUpOrDown(direction);

      if (!isRow)
      {
          coord = swapValues(coord);
          offset = swapValues(offset);
          row = coord.$2;
          column = coord.$1;
          startvalue = coord.$2;
      }
      
      //saves the square root of the board's length as a "constant"
      int upperbound = sqrt(_gameBoard.length) as int;

      //sets the value to the upperbound if offset.one is greater than 0, 0 if not.
      int comparingValue = (offset.$1 > 0)
                        ? upperbound
                        : 0;

      for (int rowOrColumn = startvalue; straightIteration(rowOrColumn, comparingValue); rowOrColumn += offset.$1)
      {
          if (isRow) {
            row = rowOrColumn;
          }                   
          else {
                column = rowOrColumn; 
          }


          var position = Position(row, column);

          if (outOfBounds(position, upperbound, direction)) {
              break;
          }
              
          (bool, Position) isnull = isNull(position, direction, position);

          if (isnull.$1) {
              position = isnull.$2;
              moveset.add(position);
          }                   
          else {
              break;  
          }
              
      }

      return moveset;
  }



  /// <summary>
  /// Swaps the values in a tuple.
  /// </summary>
  /// <typeparam name="T"></typeparam>
  /// <param name="values"></param>
  /// <returns></returns>
  static (T, T) swapValues<T>((T, T) values) =>
              values = (values.$2, values.$1);
  

  /// <summary>
  /// Checks if a direction is up or down.
  /// </summary>
  /// <param name="direction"></param>
  /// <returns>true if direction is up or down</returns>
  static bool isUpOrDown(Direction direction) 
      => direction.rowOffset != 0;

  /// <summary>
  /// Gets the diagonal iteration bool.
  /// </summary>
  /// <param name="value"></param>
  /// <param name="upperbound"></param>
  /// <returns></returns>
  static bool diagonalIteration(int value, [int upperbound = 0])
  {
      bool validator = (upperbound == 0)
                  ? value > 0
                  : value < upperbound - 1;

      return validator;
  }

  /// <summary>
  /// Gets the straight iteration bool.
  /// </summary>
  /// <param name="value"></param>
  /// <param name="upperbound"></param>
  /// <returns>true if idk</returns>
  static bool straightIteration(int value, [int upperbound = 0])
  {
      bool validator = (upperbound == 0)
                  ? value >= 0
                  : value <= upperbound - 1;

      return validator;
  }


  /// <summary>
  /// Checks whether or not a cell in a straight move  is empty and the offset position.
  /// </summary>
  /// <param name="board"></param>
  /// <param name="position"></param>
  /// <param name="direction"></param>
  /// <returns>True if cell is empty.</returns>
  static (bool, Position) isNull(Position position, Direction direction, Position nextPosition)
  {
      nextPosition = getOffsetPosition(position, direction);
      bool result = true;
      
      if (_gameBoard[nextPosition.row][nextPosition.column].type != PieceType.empty)
      {
        result = false;
      }

      return (result, nextPosition);
  }

  /// <summary>
  /// Checks whether or not if a position offset by its direction is out of bounds.
  /// </summary>
  /// <param name="position"></param>
  /// <param name="upperBound"></param>
  /// <param name="row"></param>
  /// <param name="column"></param>
  /// <returns>True if the position is out of bounds.</returns>
  static bool outOfBounds(Position position, int upperBound, Direction direction)
  {
      var offsetPosition = getOffsetPosition(position, direction);

      return _outOfBounds(offsetPosition.row, upperBound)
              || _outOfBounds(offsetPosition.column, upperBound);
  }

  /// <summary>
  /// Checks whether or not if a coordinate is out of bounds.
  /// </summary>
  /// <param name="position"></param>
  /// <param name="upperBound"></param>
  /// <returns>True if coordinate is out of bounds.</returns>
  static bool _outOfBounds(int position, int upperBound) =>
        0 > position || position >= upperBound;

  /// <summary>
  /// Creates a new position offset by a direction.
  /// </summary>
  /// <param name="position"></param>
  /// <param name="row"></param>
  /// <param name="column"></param>
  /// <returns>An offset position.</returns>
  static Position getOffsetPosition(Position position, Direction direction) 
      => Position((position.row + direction.rowOffset).abs(),
          (position.column + direction.columnOffset).abs());



          

}


