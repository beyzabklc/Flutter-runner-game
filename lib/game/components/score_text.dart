import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

import '../game_config.dart';
import '../runner_game.dart';

class ScoreText extends TextComponent with HasGameReference<RunnerGame> {
  int _shownScore = 0;

  ScoreText()
      : super(
          text: '0',
          position: Vector2(gameWidth - 20, 16),
          anchor: Anchor.topRight,
          textRenderer: TextPaint(
            style: const TextStyle(
              color: Color(0xFF1D3557),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        );

  @override
  void update(double dt) {
    super.update(dt);

    final score = game.score;
    if (score != _shownScore) {
      _shownScore = score;
      text = '$score';
    }
  }
}