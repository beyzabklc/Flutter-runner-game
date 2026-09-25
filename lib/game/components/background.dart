import 'dart:ui';

import 'package:flame/components.dart';

import '../game_config.dart';

class Background extends PositionComponent {
  Background() : super(size: Vector2(gameWidth, gameHeight));

  @override
  void onLoad() {
    addAll([
      RectangleComponent(
        size: Vector2(gameWidth, groundY),
        paint: Paint()..color = const Color(0xFF8ECAE6),
      ),
      RectangleComponent(
        position: Vector2(0, groundY),
        size: Vector2(gameWidth, gameHeight - groundY),
        paint: Paint()..color = const Color(0xFF6B4F3A),
      ),
    ]);
  }
}