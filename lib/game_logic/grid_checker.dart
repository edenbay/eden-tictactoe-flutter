

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

  PieceType allAreOfTypeIn(List<List<Piece>> pieces) {                            
    var returnType = PieceType.empty;

    for (var type in _getPlayerTypes()) {
      if (pieces.any((pieces) => pieces.every((piece) => 
        piece.type == type))) {
          returnType = type;
          break;
        }

    }
    
    return returnType;
  }
                             
  

  PieceType checkChunks() {

    PieceType result = PieceType.empty;

    for (var chunks in _getAllDirections()) {
      var type = allAreOfTypeIn(chunks);

      if (type != PieceType.empty) {
        result = type;
        break;
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

  ///Retrieves all cells in a dual diagonal cross pattern.
  List<List<Piece>> diagonalChunks(List<Piece> pieces) {
    
    List<List<Piece>> diagonalSlice = [];

    for (int pass = 0; pass < 2; pass++) {
      bool fromLeft = true;

      if (pass > 0) {
        fromLeft = false;
      }

      var list = List.generate(_chunks, 
      (i) => pieces.skip(_diagonalSkip(fromLeft, i))
                  .take(_amount)
                  .toList()[0]);

    diagonalSlice.add(list); 
    }

    return diagonalSlice;
  }

  ///checks if the skip is from the left, and returns a new position to skip to.
  int _diagonalSkip(bool fromLeft, int iteration) {
    var skipTo = 0;

    if (fromLeft) {      
      skipTo = iteration * (_chunks + 1);
      
    }
    else {
      for (int i = -1; i < iteration; i++) {
        skipTo += (_chunks - 1);
      }
    }
    return skipTo;
  }

}
