import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';

import 'components/background.dart';
import 'components/obstacle.dart';
import 'components/player.dart';
import 'components/score_text.dart';
import 'game_assets.dart';
import 'game_config.dart';

enum GameState { mainMenu, playing, paused, gameOver }

class RunnerGame extends FlameGame with TapCallbacks, HasCollisionDetection {
  static const String mainMenuOverlay = 'mainMenu';
  static const String pauseButtonOverlay = 'pauseButton';
  static const String pauseMenuOverlay = 'pauseMenu';
  static const String gameOverOverlay = 'gameOver';
  static const int _pointsPerSecond = 10;

  RunnerGame({required this.onGameOver})
      : super(
          camera: CameraComponent.withFixedResolution(
            width: gameWidth,
            height: gameHeight,
          ),
        );

  final void Function(int score) onGameOver;

  late final Player _player;
  late final AudioPool _jumpSound;
  late final AudioPool _hitSound;
  GameState _state = GameState.mainMenu;
  double _survivalTime = 0;

  int get score => (_survivalTime * _pointsPerSecond).floor();

  @override
  Future<void> onLoad() async {
    // Tüm görseller ve sesler oyun başlamadan önce bir kez belleğe alınıyor.
    await images.loadAll(GameAssets.images);
    _jumpSound = await FlameAudio.createPool(
      GameAssets.jumpSound,
      maxPlayers: 2,
    );
    _hitSound = await FlameAudio.createPool(
      GameAssets.hitSound,
      maxPlayers: 1,
    );

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

    goToMainMenu();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _survivalTime += dt;
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (_state == GameState.playing && _player.jump()) {
      _jumpSound.start();
    }
  }

  @override
  void onRemove() {
    _jumpSound.dispose();
    _hitSound.dispose();
    super.onRemove();
  }

  void startGame() {
    _resetRun();
    _state = GameState.playing;
    _showOnly(pauseButtonOverlay);
    resumeEngine();
  }

  void pauseGame() {
    if (_state != GameState.playing) return;

    _state = GameState.paused;
    pauseEngine();
    _showOnly(pauseMenuOverlay);
  }

  void resumeGame() {
    _state = GameState.playing;
    _showOnly(pauseButtonOverlay);
    resumeEngine();
  }

  void gameOver() {
    if (_state != GameState.playing) return;

    _state = GameState.gameOver;
    pauseEngine();
    _hitSound.start();
    onGameOver(score);
    _showOnly(gameOverOverlay);
  }

  void goToMainMenu() {
    _state = GameState.mainMenu;
    pauseEngine();
    _showOnly(mainMenuOverlay);
  }

  void _resetRun() {
    _survivalTime = 0;
    _player.reset();
    world.removeAll(world.children.whereType<Obstacle>());
  }

  void _showOnly(String overlay) {
    overlays.clear();
    overlays.add(overlay);
  }
}