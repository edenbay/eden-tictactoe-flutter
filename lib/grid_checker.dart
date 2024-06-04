
import 'dart:js_interop';

import 'piece.dart';

import 'piece_type.dart';



class GridChecker {

  List<List<Piece>> _horizontals = [];
  List<List<Piece>> _verticals = [];
  List<List<Piece>> _diagonals = [];

  List<List<List<Piece>>> _allDirections = [];

  late int _amount;
  late int _chunks;


  void setValues(List<Piece> pieces, int amount) {
    _amount = amount;
    _chunks = (pieces.length / _amount).ceil();

    _horizontals = horizontalChunks(pieces);
    _verticals = verticalChunks(_horizontals);
    _diagonals = diagonalChunks(pieces);  
  }

  PieceType retrieveWinner(List<Piece> pieces, int amount) {
    setValues(pieces, amount);
    return checkChunks();
  }

  
  List<PieceType> _getPlayerTypes() {
    return [
      PieceType.cross,
      PieceType.circle
    ];
  }

  List<List<List<Piece>>> _getAllDirections() => [
    _horizontals,
    _verticals,
    _diagonals
  ];

  bool allAreOfTypeIn(List<List<Piece>> pieces, PieceType type) =>
                            pieces.any((pieces) => 
                            pieces.every((piece) 
                            => piece.type == type));  
  

  PieceType checkChunks() {

    PieceType result = PieceType.empty;

    for (var chunks in _getAllDirections()) {
      for (var type in _getPlayerTypes()) {
        if (allAreOfTypeIn(chunks, type)) {
          result = type;
          break;
        }    
      }  
    }
    

    return result;
  }
  //se till att bara använda dessa om circle >= 3 || cross >= 3;
  
  List<List<Piece>> horizontalChunks(List<Piece> pieces) {
    return List.generate(_chunks, 
    (i) => pieces.skip(i * _amount).take(_amount).toList());
  }

  /// turns a 2d array of pieces into [size] amount of vertical chunks. 
  List<List<Piece>> verticalChunks(List<List<Piece>> pieces) {
    
    List<List<Piece>> verticalSlices = [];

    for (int col = 0; col < _amount; col++) {
        List<Piece> column = [];
      for (int row = 0; row < _amount; row++) {
        column.add(pieces[row][col]);
      }
      verticalSlices.add(column);
    }

    return verticalSlices;
  }

  //retrieves all cells in a dual diagonal cross pattern.
  List<List<Piece>> diagonalChunks(List<Piece> pieces) {
    List<List<Piece>> diagonalSlice = [];
    ///en lista med två underlistor.
    /// Behöver hamna i samma lista: [[2, 4, 6],
    ///                               [0, 4, 8]]
    /// 
    /// 0
    ///   0
    ///     0
    /// 
    ///     0
    ///   0
    /// 0
    /// 
    // var list = List.generate(_chunks, 
    // (i) => pieces.skip(i * 4).take(_amount).toList()[0]);

    // diagonalSlice.add(list); 
    // int pos = 0;
    // list = List.generate(_chunks, 
    // (i) => pieces.skip(pos += 2).take(_amount).toList()[0]);

    List<Piece> list = [];

    for (int pass = 0; pass < 2; pass++) {
      bool fromLeft = true;

      if (pass > 0) {
        fromLeft = false;
      }

      list = List.generate(_chunks, 
      (i) => pieces.skip(_diagonalSkip(fromLeft, i)).take(_amount).toList()[0]);
    }

    diagonalSlice.add(list); 

    return diagonalSlice;
  }

  ///checks if the skip is from the left, and returns a new position to skip to.
  int _diagonalSkip(bool fromLeft, int position, [int iteration = -1]) {
    if (fromLeft) {      
      position = iteration * _chunks + 1;
    }
    else {
      position += _chunks - 1;
    }

    return position;
  }

}
  

  //chunks in sets of three:
  //i= 0, j = 0++
  //0 0 0
  //0 0 0
  //0 0 0

  //som en nästlad for loop.
  //for each List[0++][0]


//vertical
//col 1   col 2   col 3
//[0][0], [0][1], [0][2]
//[1][0], [1][1], [1][2]
//[2][0], [2][0], [2][2]

  //  List<List<int>> [
  //                  [1, 2, 3], 
  //                  [4, 5, 6], 
  //                  [7, 8, 9]
  //                           ];
  //  
  //  print(chunks) //[
  //                  [1, 4, 7], 
  //                  [2, 5, 8], 
  //                  [3, 6, 9]
  //                           ];
  //

