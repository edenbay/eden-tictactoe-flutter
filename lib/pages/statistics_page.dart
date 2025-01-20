import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/components/circle.dart';
import 'package:tic_tac_toe/components/cross.dart';
import 'package:tic_tac_toe/components/line.dart';
import 'package:tic_tac_toe/main.dart';

import '../components/shape.dart';
import '../game_logic/enums/outcome.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var results = appState.results;

    return SafeArea(
        child: ListView.builder(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
      itemCount: results.length,
      itemBuilder: (BuildContext context, int index) {
        var outcome = results[index];
        return Container(
          height: 90,
          margin: EdgeInsets.only(bottom: 5.0),
          decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border(bottom: BorderSide(color: Colors.white54))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              constructShape(Cross(), outcome),
              constructText('-', color: Colors.white70),
              constructShape(Circle(), outcome),
            ],
          ),
        );
      },
    ));
  }

  Widget constructShape(Shape shape, Outcome outcome) {
    var shapeWidget = Transform.scale(
      scale: 0.75,
      child: shape,
    );
    (String, String) ints = ('0', '0');

    if (outcome == Outcome.circle) {
      ints = ('1', '0');
    }
    if (outcome == Outcome.cross) {
      ints = ('0', '1');
    }
    (Text, Text) text = (constructText(ints.$1), constructText(ints.$2));

    if (shape is Circle) {
      return Row(
        children: [
          text.$1,
          shapeWidget,
        ],
      );
    } else {
      return Row(
        children: [
          shapeWidget,
          text.$2,
        ],
      );
    }
  }
}

Text constructText(String text, {Color color = Colors.white}) => Text(
      text,
      textScaler: TextScaler.linear(3.5),
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w700,
        shadows: [
          Shadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            offset: Offset(0, 4),
          )
        ],
      ),
    );
