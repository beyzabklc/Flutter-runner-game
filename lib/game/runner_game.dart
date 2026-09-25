import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'components/background.dart';
import 'game_config.dart';
import 'components/player.dart';

class RunnerGame extends FlameGame {
  RunnerGame()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: gameWidth,
            height: gameHeight,
          ),
        );

  @override
  void onLoad() {
    // World'ün (0,0) noktası ekranın sol üst köşesi olsun.
    camera.viewfinder.anchor = Anchor.topLeft;

       world.addAll([Background(), Player()]);
  }
}