import 'package:flutter/material.dart';

import '../../game/runner_game.dart';

class PauseButton extends StatelessWidget {
  final RunnerGame game;

  const PauseButton({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: IconButton(
          onPressed: game.pauseGame,
          icon: const Icon(Icons.pause, size: 32),
          color: const Color(0xFF1D3557),
        ),
      ),
    );
  }
}