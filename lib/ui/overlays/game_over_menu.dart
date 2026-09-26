import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../game/runner_game.dart';
import '../../state/high_score_cubit.dart';
import '../menu_panel.dart';

class GameOverMenu extends StatelessWidget {
  final RunnerGame game;

  const GameOverMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return MenuPanel(
      title: 'Game Over',
      children: [
        Text(
          'Score: ${game.score}',
          style: const TextStyle(color: Colors.white, fontSize: 22),
        ),
        const SizedBox(height: 4),
        BlocBuilder<HighScoreCubit, int>(
          builder: (context, highScore) => Text(
            'Best: $highScore',
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: game.startGame,
          child: const Text('Restart'),
        ),
        TextButton(
          onPressed: game.goToMainMenu,
          child: const Text(
            'Main Menu',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}