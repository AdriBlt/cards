import 'package:cards/player_info.dart';
import 'package:cards/state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PlayerInfo(playerIndex: 0),
                PlayerInfo(playerIndex: 1),
              ],
            ),
            Expanded(child: Row(children: [])), // TODO
            Row(
              children: [
                PlayerInfo(playerIndex: 3),
                NavigationButtons(),
                PlayerInfo(playerIndex: 2),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<GameState>();

    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            onPressed: appState.canGoPrevious()
                ? () {
                    appState.previousStep();
                  }
                : null,
            icon: Icon(Icons.arrow_back),
            label: Text('Back'),
          ),
          SizedBox(width: 10),
          ElevatedButton.icon(
            onPressed: appState.canGoNext()
                ? () {
                    appState.nextStep();
                  }
                : null,
            icon: Icon(Icons.arrow_forward),
            label: Text('Next'),
          ),
        ],
      ),
    );
  }
}
