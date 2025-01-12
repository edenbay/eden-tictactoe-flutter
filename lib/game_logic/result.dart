import 'package:tic_tac_toe/game_logic/enums/outcome.dart';

class Result {
  List<int>? indices;
  late final Outcome outcome;
  late final bool isGameOver;
  late final bool isWin;

  Result({required this.outcome, this.indices}) {
    this.indices = indices;

    isGameOver = (outcome != Outcome.none);
    isWin = (isGameOver && outcome != Outcome.tie);
  }
}
