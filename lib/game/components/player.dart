import 'dart:ui';

import 'package:flame/components.dart';

import '../game_config.dart';

class Player extends RectangleComponent {
  Player()
      : super(
          size: Vector2(40, 60),
          position: Vector2(120, groundY),
          anchor: Anchor.bottomCenter,
          paint: Paint()..color = const Color(0xFFFFB703),
        );
}