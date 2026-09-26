import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'game/runner_game.dart';
import 'ui/overlays/game_over_menu.dart';
import 'ui/overlays/main_menu.dart';

class RunnerApp extends StatelessWidget {
  const RunnerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GameWidget<RunnerGame>.controlled(
          gameFactory: RunnerGame.new,
          overlayBuilderMap: {
            RunnerGame.mainMenuOverlay: (_, game) => MainMenu(game: game),
            RunnerGame.gameOverOverlay: (_, game) => GameOverMenu(game: game),
          },
        ),
      ),
    );
  }
}