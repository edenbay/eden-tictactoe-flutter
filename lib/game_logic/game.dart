import 'dart:async';
import 'package:tic_tac_toe/game_logic/result.dart';
import 'enums/outcome.dart';
import 'piece.dart';
import 'grid_checker.dart';
import 'enums/piece_type.dart';

class Game {
  final List<Piece> _gameboard = [];
  final _gridChecker = GridChecker();
  PieceType turn = PieceType.cross;
  late Piece _currentPiece;
  late Result result;

  late int rows;
  late int columns;
  late int length;

  List<Outcome> results = [];

  Game(int multiplier) {
    rows = multiplier;
    columns = multiplier;

    length = rows * columns;
    _setupBoard();
  }

  /// Gets a list of all results.
  List<Outcome> getResults() => results;

  ///Gets the gameboard.
  List<Piece> getBoard() => _gameboard;

  /// Sets up the game board, sets all pieces to empty
  ///  and their gridPositions to the corresponding row and column.
  void _setupBoard() {
    for (int i = 0; i < length; i++) {
      _gameboard.add(Piece(PieceType.none, i));
    }
  }

  //updates the cell at position [x,x] to the correct type.
  Outcome tryPlace(int position) {
    _currentPiece = _gameboard.elementAt(position);

    if (!canPlace()) {
      return Outcome.none;
    }
    _currentPiece.updatePiece(turn);
    result = _getResult();

    if (result.outcome == Outcome.none) {
      changeTurn();
    } else {
      _postResult(result.outcome);
    }

    return result.outcome;
  }

  ///checks if the piece and the pressed location is empty, if true = canPlace
  bool canPlace() => _currentPiece.type == PieceType.none;

  void changeTurn() {
    turn = (turn == PieceType.circle) ? PieceType.cross : PieceType.circle;
  }

  Result _getResult() => _gridChecker.retrieveResultStatus(_gameboard);

  void _postResult(Outcome result) => results.add(result);

  void resetGame() {
    _gameboard.forEach((_resetType));
    turn = PieceType.cross;
    result = Result(outcome: Outcome.none);
  }

  void _resetType(Piece piece) {
    piece.type = PieceType.none;
  }
}
