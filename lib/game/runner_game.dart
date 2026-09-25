import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

import 'components/background.dart';
import 'components/player.dart';
import 'game_config.dart';

class RunnerGame extends FlameGame with TapCallbacks {
  RunnerGame()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: gameWidth,
            height: gameHeight,
          ),
        );

  late final Player _player;

  @override
  void onLoad() {
    // World'ün (0,0) noktası ekranın sol üst köşesi olarak belirledim.
    camera.viewfinder.anchor = Anchor.topLeft;

    _player = Player();
    world.addAll([Background(), _player]);
  }

  @override
  void onTapDown(TapDownEvent event) {
    _player.jump();
  }
}