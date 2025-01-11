import 'package:tic_tac_toe/game_logic/result.dart';

import 'enums/outcome.dart';

import 'piece.dart';

import 'enums/piece_type.dart';

class GridChecker {
  static List<List<Piece>> _horizontals = [];
  static List<List<Piece>> _verticals = [];
  static List<List<Piece>> _diagonals = [];
  static List<Piece> _pieces = [];
  static int _amount = 0;
  static int _chunks = 0;

  GridChecker._privateConstructor();

  static final GridChecker _instance = GridChecker._privateConstructor();

  factory GridChecker() {
    return _instance;
  }

  Result retrieveResultStatus(List<Piece> pieces, int amount) {
    _updateValues(pieces, amount);
    // checkTheseNuts();
    return getResult();
  }

  void _updateValues(List<Piece> pieces, int amount) {
    _amount = amount;
    _chunks = (pieces.length / _amount).ceil();
    _pieces = pieces;

    _horizontals = _horizontalChunks(pieces);
    _verticals = _verticalChunks(_horizontals);
    _diagonals = _diagonalChunks(pieces);
  }

  List<PieceType> _getPlayerTypes() {
    return [PieceType.cross, PieceType.circle];
  }

  List<List<List<Piece>>> _getAllDirections() =>
      [_horizontals, _verticals, _diagonals];

  Result getResult() {
    var point = checkAll();

    //win occurred
    if (point != null) {
      return Result(
          outcome: outcomeFromType(point.$1!.type), //winner
          indices: [point.$1!.position, point.$2!.position]);
    }

    //all filled, tie
    if (_allFilled()) {
      return Result(outcome: Outcome.tie);
    } else {
      //no end-result
      return Result(outcome: Outcome.none);
    }
  }

  Outcome outcomeFromType(PieceType type) =>
      Outcome.values.singleWhere((o) => o.name == type.name);

  //driver kod
  (Piece?, Piece?)? checkAll() {
    List<(Piece?, Piece?)> points = List.empty(growable: true);

    for (var i = 0; i < 3; i++) {
      points.add(getFirstAndLastIfAllSame(getHorizontal(i)));
      points.add(getFirstAndLastIfAllSame(getVertical(i)));

      if (i > 0) {
        //allows for calling diagonal with boolean value
        points.add(getFirstAndLastIfAllSame(getDiagonal(i.isOdd)));
      }
    }

    return points.where((point) => point.$1 != null).firstOrNull;
  }

  (Piece?, Piece?) getFirstAndLastIfAllSame(List<Piece> pieces) {
    (Piece?, Piece?) output = (null, null);
    _getPlayerTypes().forEach((type) {
      if (allAre(pieces, type)) {
        output = getFirstAndLastOf(pieces);
      }
    });

    return output;
  }

  ///All elements in pieces are of the specified type
  bool allAre(List<Piece> pieces, PieceType type) =>
      pieces.every((p) => p.type == type);

  (Piece, Piece) getFirstAndLastOf(List<Piece> pieces) =>
      (pieces.first, pieces.last);

  ///Gets a list of the pieces in row
  List<Piece> getHorizontal(int row) {
    return _pieces.sublist(2 * row).take(3).toList();
  }

  ///Gets a list of the pieces in column
  List<Piece> getVertical(int column) {
    int a = column, b = a + 3, c = b + 3;
    return [_pieces[a], _pieces[b], _pieces[c]];
  }

  ///Gets a list of the pieces in diagonal from start or end
  List<Piece> getDiagonal(bool fromStart) {
    var _full = (fromStart) ? _pieces : _pieces.reversed;
    int a = 0, b = a + 4, c = b + 4;
    return [_pieces[a], _pieces[b], _pieces[c]];
  }

  //   List<List<Piece>> _horizontalChunks(List<Piece> pieces) {
  //   return List.generate(
  //       _chunks, (i) => pieces.skip(i * _amount).take(_amount).toList());
  // }

  ///checks all chunks for a result
  // Outcome checkChunks() {
  //   //any chunk is of a single type
  //   for (PieceType type in _getPlayerTypes()) {
  //     if (_anyContainsAllOf(_getAllDirections(), type)) {
  //       return Outcome.values.singleWhere((value) => value.name == type.name);
  //     }
  //   }

  //   //all are filled but no win
  //   if (_allAreFilled(_getAllDirections())) return Outcome.tie;

  //   //no one won.
  //   return Outcome.none;
  // }

  bool _allFilled() => !_pieces.any((p) => p.type == PieceType.none);

  Outcome checkChunks() {
    //any chunk is of a single type
    for (PieceType type in _getPlayerTypes()) {
      if (_anyContainsAllOf(_getAllDirections(), type)) {
        return Outcome.values.singleWhere((value) => value.name == type.name);
      }
    }

    //all are filled but no win
    if (_allAreFilled(_getAllDirections())) return Outcome.tie;

    //no one won.
    return Outcome.none;
  }

  //returns true if none of the pieces are of type none.
  bool _allAreFilled(List<List<List<Piece>>> allDirections) =>
      allDirections.every((chunk) => chunk.every(
          (subList) => subList.every((piece) => piece.type != PieceType.none)));

  //returns true if any chunk contains all of type.
  bool _anyContainsAllOf(
          List<List<List<Piece>>> allDirections, PieceType type) =>
      allDirections.any((chunks) =>
          chunks.any((chunk) => chunk.every((piece) => piece.type == type)));

  // List<List<Piece>> _getListWhereAll(
  //         List<List<List<Piece>>> allDirections, PieceType type) =>
  //     allDirections.where((chunks) =>
  //         chunks.any((chunk) => chunk.every((piece) => piece.type == type)));

  //se till att bara använda dessa om circle >= 3 || cross >= 3;
  List<List<Piece>> _horizontalChunks(List<Piece> pieces) {
    return List.generate(
        _chunks, (i) => pieces.skip(i * _amount).take(_amount).toList());
  }

  /// turns a 2d array of pieces into [size] amount of vertical chunks.
  List<List<Piece>> _verticalChunks(List<List<Piece>> pieces) {
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

  ///retrieves all cells in a dual diagonal cross pattern.
  List<List<Piece>> _diagonalChunks(List<Piece> pieces) {
    List<List<Piece>> diagonalSlice = [];

    for (int pass = 0; pass < 2; pass++) {
      bool fromLeft = true;

      if (pass > 0) {
        fromLeft = false;
      }

      var list = List.generate(
          _chunks,
          (i) => pieces
              .skip(_diagonalSkip(fromLeft, i))
              .take(_amount)
              .toList()[0]);

      diagonalSlice.add(list);
    }

    return diagonalSlice;
  }

  ///checks if the skip is from the left, and returns a new position to skip to.
  int _diagonalSkip(bool fromLeft, int iteration) {
    int skipTo = 0;

    if (fromLeft) {
      skipTo = iteration * (_chunks + 1);
    } else {
      for (int i = -1; i < iteration; i++) {
        skipTo += (_chunks - 1);
      }
    }
    return skipTo;
  }
}
