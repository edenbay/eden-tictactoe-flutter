import 'package:flutter/material.dart';
import 'package:tic_tac_toe/main.dart';

import 'game_page.dart';
import 'statistics_page.dart';

class MyHomePage extends State<NaviBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;

    switch (currentPageIndex) {
      case 0:
        page = const GamePage();
      case 1:
        page = const StatisticsPage();
      default:
        throw UnimplementedError('no widget found for $currentPageIndex');
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.surfaceContainerLowest,
              child: page,
            ),
          ),
          NavigationBar(
            animationDuration: Duration(milliseconds: 1000),
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.gamepad),
                label: 'Tic Tac Toe',
              ),
              NavigationDestination(
                icon: Icon(Icons.wysiwyg),
                label: 'Statistics',
              ),
            ],
            selectedIndex: currentPageIndex,
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
              });
              print('selected: $index');
            },
          ),
        ],
      ),
    );
  }
}
