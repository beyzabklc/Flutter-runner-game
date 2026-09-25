import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../game_config.dart';

class Obstacle extends RectangleComponent {
  static const double _speed = 300;
  static final Paint _paint = Paint()..color = const Color(0xFFD62828);
  static final Random _random = Random();

  Obstacle({required Vector2 size})
      : super(
          size: size,
          position: Vector2(gameWidth, groundY),
          anchor: Anchor.bottomLeft,
          paint: _paint,
        );

  factory Obstacle.random() {
    final width = 30 + _random.nextDouble() * 20;
    final height = 40 + _random.nextDouble() * 30;
    return Obstacle(size: Vector2(width, height));
  }

  @override
  void onLoad() {
    // Engeller birbirleriyle kontrol edilmesin, sadece player ile.
    add(RectangleHitbox(collisionType: CollisionType.passive));
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= _speed * dt;

    if (position.x + size.x < 0) {
      removeFromParent();
    }
  }
}