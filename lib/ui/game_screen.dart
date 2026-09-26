import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../game/runner_game.dart';
import '../state/high_score_cubit.dart';
import 'overlays/game_over_menu.dart';
import 'overlays/main_menu.dart';
import 'overlays/pause_button.dart';
import 'overlays/pause_menu.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final highScoreCubit = context.read<HighScoreCubit>();

    return Scaffold(
      body: GameWidget<RunnerGame>.controlled(
        gameFactory: () => RunnerGame(onGameOver: highScoreCubit.submitScore),
        overlayBuilderMap: {
          RunnerGame.mainMenuOverlay: (_, game) => MainMenu(game: game),
          RunnerGame.pauseButtonOverlay: (_, game) => PauseButton(game: game),
          RunnerGame.pauseMenuOverlay: (_, game) => PauseMenu(game: game),
          RunnerGame.gameOverOverlay: (_, game) => GameOverMenu(game: game),
        },
      ),
    );
  }
}