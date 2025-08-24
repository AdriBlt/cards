import 'package:cards/state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayerInfo extends StatelessWidget {
  const PlayerInfo({super.key, required this.playerIndex});

  final int playerIndex;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<GameState>();
    var isInitState = appState.gameStep == GameStatus.initialize;

    final theme = Theme.of(context);

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 350,
          child: isInitState
              ? PlayerNameInput(playerIndex: playerIndex)
              : PlayerStats(playerIndex: playerIndex),
        ),
      ),
    );
  }
}

class PlayerNameInput extends StatelessWidget {
  const PlayerNameInput({super.key, required this.playerIndex});

  final int playerIndex;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<GameState>();
    var player = appState.players[playerIndex];

    TextEditingController controller = TextEditingController(text: player.name);

    final theme = Theme.of(context);
    final styleLarge = theme.textTheme.displayLarge!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Row(
      children: [
        Icon(Icons.person, size: 50, color: theme.colorScheme.onPrimary),
        Expanded(
          child: TextField(
            controller: controller,
            onChanged: (value) => appState.setPlayerName(playerIndex, value),
            style: styleLarge,
          ),
        ),
      ],
    );
  }
}

class PlayerStats extends StatelessWidget {
  const PlayerStats({super.key, required this.playerIndex});

  final int playerIndex;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<GameState>();
    var gameIndex = appState.gameIndex;
    var player = appState.players[playerIndex];
    var requested = player.getRequested(gameIndex)?.toString() ?? "";

    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    final styleSmall = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    final styleLarge = theme.textTheme.displayLarge!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Row(
      children: [
        Icon(Icons.person, size: 50, color: theme.colorScheme.onPrimary),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(player.name, style: style),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.emoji_events, color: theme.colorScheme.onPrimary),
                  Text(player.getTotalScore().toString(), style: styleSmall),
                ],
              ),
            ],
          ),
        ),
        Text(requested, style: styleLarge),
      ],
    );
  }
}
