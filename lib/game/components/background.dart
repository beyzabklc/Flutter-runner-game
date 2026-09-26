import 'package:flame/components.dart';
import 'package:flame/parallax.dart';

import '../game_assets.dart';
import '../game_config.dart';
import '../runner_game.dart';

class Background extends ParallaxComponent<RunnerGame> {
  Background() : super(size: Vector2(gameWidth, gameHeight));

  @override
  Future<void> onLoad() async {
    // Katman hızları sırasıyla taban x1, x5, x25.
    // Zemin (son katman) engellerle aynı hızda aksın diye taban = worldSpeed / 25.
    parallax = await game.loadParallax(
      [
        ParallaxImageData(GameAssets.sky),
        ParallaxImageData(GameAssets.hills),
        ParallaxImageData(GameAssets.ground),
      ],
      size: size,
      baseVelocity: Vector2(worldSpeed / 25, 0),
      velocityMultiplierDelta: Vector2(5, 1),
    );
  }
}