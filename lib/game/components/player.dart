import 'dart:ui';

import 'package:flame/components.dart';

import '../game_config.dart';

class Player extends RectangleComponent {
  static const double _gravity = 1800;
  static const double _jumpSpeed = -700;

  double _verticalSpeed = 0;

  Player()
      : super(
          size: Vector2(40, 60),
          position: Vector2(120, groundY),
          anchor: Anchor.bottomCenter,
          paint: Paint()..color = const Color(0xFFFFB703),
        );

  bool get isOnGround => position.y >= groundY;

  void jump() {
    if (isOnGround) {
      _verticalSpeed = _jumpSpeed;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    _verticalSpeed += _gravity * dt;
    position.y += _verticalSpeed * dt;

    if (position.y > groundY) {
      position.y = groundY;
      _verticalSpeed = 0;
    }
  }
}