import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../game_assets.dart';
import '../game_config.dart';
import '../runner_game.dart';
import 'obstacle.dart';

class Player extends SpriteAnimationComponent
    with HasGameReference<RunnerGame>, CollisionCallbacks {
  static const double _gravity = 1800;
  static const double _jumpSpeed = -700;

  double _verticalSpeed = 0;

  Player()
      : super(
          size: Vector2(40, 60),
          position: Vector2(120, groundY),
          anchor: Anchor.bottomCenter,
        );

  bool get isOnGround => position.y >= groundY;

  @override
  void onLoad() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache(GameAssets.player),
      SpriteAnimationData.sequenced(
        amount: 2,
        stepTime: 0.15,
        textureSize: Vector2(80, 120),
      ),
    );

    // Görselin kenarlarındaki boşluklar çarpışma sayılmasın.
    add(RectangleHitbox(position: Vector2(8, 6), size: Vector2(24, 54)));
  }

   bool jump() {
    if (!isOnGround) return false;

    _verticalSpeed = _jumpSpeed;
    return true;
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