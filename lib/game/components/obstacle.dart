import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../game_assets.dart';
import '../game_config.dart';
import '../runner_game.dart';

enum ObstacleType {
  smallRock(GameAssets.smallRock, 40, 36),
  bigRock(GameAssets.bigRock, 52, 56),
  crystal(GameAssets.crystal, 32, 64);

  const ObstacleType(this.imageName, this.width, this.height);

  final String imageName;
  final double width;
  final double height;
}

class Obstacle extends SpriteComponent with HasGameReference<RunnerGame> {
  static final Random _random = Random();

  final ObstacleType type;

  Obstacle(this.type)
      : super(
          size: Vector2(type.width, type.height),
          position: Vector2(gameWidth, groundY),
          anchor: Anchor.bottomLeft,
        );

  factory Obstacle.random() {
    const types = ObstacleType.values;
    return Obstacle(types[_random.nextInt(types.length)]);
  }

  @override
  void onLoad() {
    sprite = Sprite(game.images.fromCache(type.imageName));

    // Engeller birbirleriyle kontrol edilmesin, sadece player ile.
    add(RectangleHitbox(collisionType: CollisionType.passive));
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= worldSpeed * dt;

    if (position.x + size.x < 0) {
      removeFromParent();
    }
  }
}