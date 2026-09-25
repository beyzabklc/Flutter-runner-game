import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

import 'components/background.dart';
import 'components/obstacle.dart';
import 'components/player.dart';
import 'components/score_text.dart';
import 'game_config.dart';

class RunnerGame extends FlameGame with TapCallbacks, HasCollisionDetection {
  static const int _pointsPerSecond = 10;

  RunnerGame()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: gameWidth,
            height: gameHeight,
          ),
        );

  late final Player _player;
  double _survivalTime = 0;

  int get score => (_survivalTime * _pointsPerSecond).floor();

  @override
  void onLoad() {
    // World'ün (0,0) noktası ekranın sol üst köşesi olsun.
    camera.viewfinder.anchor = Anchor.topLeft;

    _player = Player();
    world.addAll([
      Background(),
      _player,
      SpawnComponent.periodRange(
        factory: (_) => Obstacle.random(),
        minPeriod: 1.0,
        maxPeriod: 2.2,
        selfPositioning: true,
      ),
    ]);

    camera.viewport.add(ScoreText());
  }

  @override
  void update(double dt) {
    super.update(dt);
    _survivalTime += dt;
  }

  @override
  void onTapDown(TapDownEvent event) {
    _player.jump();
  }

  void gameOver() {
    pauseEngine();
  }
}