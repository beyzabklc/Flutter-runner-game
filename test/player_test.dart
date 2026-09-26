import 'package:flutter_test/flutter_test.dart';
import 'package:marsky_runner/game/components/player.dart';
import 'package:marsky_runner/game/game_config.dart';

void main() {
  group('Player', () {
    test('can jump when on the ground', () {
      final player = Player();

      expect(player.jump(), isTrue);
    });

    test('cannot jump again while in the air', () {
      final player = Player();
      player.jump();
      player.update(0.1);

      expect(player.isOnGround, isFalse);
      expect(player.jump(), isFalse);
    });

    test('lands back on the ground after a jump', () {
      final player = Player();
      player.jump();

      for (var i = 0; i < 120; i++) {
        player.update(1 / 60);
      }

      expect(player.isOnGround, isTrue);
      expect(player.position.y, groundY);
    });
  });
}