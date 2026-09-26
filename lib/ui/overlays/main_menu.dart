import 'package:flutter/material.dart';

import '../../game/runner_game.dart';
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
          ElevatedButton(
            onPressed: game.startGame,
            child: const Text('Start'),
          ),
        ],
      ),
    );
  }
}