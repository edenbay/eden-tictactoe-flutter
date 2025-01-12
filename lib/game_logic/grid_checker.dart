import 'package:tic_tac_toe/game_logic/result.dart';

import 'enums/outcome.dart';

import 'piece.dart';

import 'enums/piece_type.dart';

class GridChecker {
  static List<Piece> _pieces = [];

  GridChecker._privateConstructor();

  static final GridChecker _instance = GridChecker._privateConstructor();

  factory GridChecker() {
    return _instance;
  }

  Result retrieveResultStatus(List<Piece> pieces) {
    _pieces = pieces;

    return getResult();
  }

  List<PieceType> _getPlayerTypes() {
    return [PieceType.cross, PieceType.circle];
  }

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

  ///checks all combinations for a win
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
    
    if (pieces.length < 3) {
        return output;
    }

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
        int a = row*3, b = a + 1, c = b + 1;
    return [_pieces[a], _pieces[b], _pieces[c]];
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
  ///Returns true if all pieces are filled
  bool _allFilled() => !_pieces.any((p) => p.type == PieceType.none);
}