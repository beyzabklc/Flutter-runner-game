import 'package:flutter/material.dart';

import '../../game/runner_game.dart';
import '../menu_panel.dart';

class PauseMenu extends StatelessWidget {
  final RunnerGame game;

  const PauseMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return MenuPanel(
      title: 'Paused',
      children: [
        ElevatedButton(
          onPressed: game.resumeGame,
          child: const Text('Resume'),
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