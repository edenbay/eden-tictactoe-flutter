import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/main.dart';
import 'package:tic_tac_toe/piece.dart';

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.piece
  });

  
final Piece piece;

  @override
  Widget build(BuildContext context) {
var theme = Theme.of(context);

var appState = context.watch<MyAppState>();

var style = theme.textTheme.displayMedium!.copyWith(
  color: theme.colorScheme.onPrimary,
);

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child:
          appState.getIconFromType(piece.getType()),
        ),
        );
  }
}
