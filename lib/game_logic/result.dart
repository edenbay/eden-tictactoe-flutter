import 'package:tic_tac_toe/game_logic/enums/outcome.dart';

class Result {
  List<int>? indices;
  late final Outcome outcome;

  Result({required this.outcome, this.indices}) {
    this.indices = indices;
  }
}
