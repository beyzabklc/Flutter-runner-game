import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../game/runner_game.dart';
import '../../state/high_score_cubit.dart';
import '../menu_panel.dart';

class MainMenu extends StatelessWidget {
  final RunnerGame game;

  const MainMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFF8ECAE6),
      child: MenuPanel(
        title: 'Marsky Runner',
        children: [
          BlocBuilder<HighScoreCubit, int>(
            builder: (context, highScore) => Text(
              'Best: $highScore',
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: game.startGame,
            child: const Text('Start'),
          ),
        ],
      ),
    );
  }
}