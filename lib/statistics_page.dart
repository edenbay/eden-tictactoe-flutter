import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/main.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var results = appState.results;

      return SafeArea(
        child:
          ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: results.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 50,
                color: Colors.amber,
                child: Center(child: Text(appState.fetchResult(index))),
              );
            },
          )   
        );

  }
}
