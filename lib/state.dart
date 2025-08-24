import 'dart:math' as math;
import 'package:flutter/material.dart';

enum GameStatus { initialize, dealing, betting, scoring, ended }

var gameStepsCardsCount = [
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  13,
  12,
  11,
  10,
  9,
  8,
  7,
  6,
  5,
  4,
  3,
  2,
  1,
];

class GameState extends ChangeNotifier {
  var players = <Player>[Player(), Player(), Player(), Player()];
  var firstPlayer = 0;
  var gameIndex = 0;
  var gameStep = GameStatus.initialize;

  void update() {
    notifyListeners();
  }

  void nextStep() {
    switch (gameStep) {
      case GameStatus.initialize:
        initializeGame();
        break;
      case GameStatus.dealing:
        // TODO
        break;
      case GameStatus.betting:
        // TODO
        break;
      case GameStatus.scoring:
        // TODO
        break;
      case GameStatus.ended:
        break;
    }
    notifyListeners();
  }

  bool canGoNext() {
    switch (gameStep) {
      case GameStatus.initialize:
        return players.every((p) => p.name != ""); // TODO
      case GameStatus.dealing:
        return true; // TODO
      case GameStatus.betting:
        return true; // TODO
      case GameStatus.scoring:
        return true; // TODO
      case GameStatus.ended:
        return false;
    }
  }

  void previousStep() {
    switch (gameStep) {
      case GameStatus.initialize:
        break;
      case GameStatus.dealing:
        gameStep = GameStatus.initialize;
        break;
      case GameStatus.betting:
        // TODO
        break;
      case GameStatus.scoring:
        // TODO
        break;
      case GameStatus.ended:
        // TODO
        break;
    }
    notifyListeners();
  }

  bool canGoPrevious() {
    switch (gameStep) {
      case GameStatus.initialize:
        return false;
      case GameStatus.dealing:
        return true; // TODO
      case GameStatus.betting:
        return true; // TODO
      case GameStatus.scoring:
        return true; // TODO
      case GameStatus.ended:
        return true; // TODO
    }
  }

  void initializeGame() {
    gameStep = GameStatus.dealing;
    firstPlayer = math.Random().nextInt(players.length);
    gameIndex = 0;
  }

  void setPlayerName(int playerIndex, String value) {
    players[playerIndex].name = value;
    notifyListeners();
  }
}

class Player {
  var name = "";
  var requested = <int>[];
  var done = <int>[];

  void setName(String n) {
    name = n;
    // notifyListeners();
  }

  void setRequested(int index, int value) {
    requested[index] = value;
  }

  void setDone(int index, int value) {
    done[index] = value;
  }

  int getTotalScore() {
    var score = 0;

    var length = math.min(requested.length, done.length);
    for (var i = 0; i < length; i++) {
      score += getScore(requested[i], done[i]);
    }

    return score;
  }

  int? getRequested(int index) {
    if (index < requested.length) {
      return requested[index];
    }

    return null;
  }

  int? getDone(int index) {
    if (index < done.length) {
      return done[index];
    }

    return null;
  }
}

int getScore(int requested, int done) {
  if (requested == done) {
    return 10 + 5 * requested;
  } else {
    return -5 * (requested - done).abs();
  }
}
