import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../game_config.dart';
import '../runner_game.dart';
import 'obstacle.dart';

class Player extends RectangleComponent
    with HasGameReference<RunnerGame>, CollisionCallbacks {
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

  @override
  void onLoad() {
    add(RectangleHitbox());
  }

  void jump() {
    if (isOnGround) {
      _verticalSpeed = _jumpSpeed;
    }
  }
    void reset() {
    position.y = groundY;
    _verticalSpeed = 0;
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

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Obstacle) {
      game.gameOver();
    }
  }
}