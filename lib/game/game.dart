import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flutter_bird/game/bird.dart';
import 'package:flutter_bird/game/horizont.dart';

class FlutterBirdGame extends BaseGame {
  Horizon horizon;
  Bird bird;

  FlutterBirdGame({Image spriteImage}) {

    horizon = Horizon(spriteImage);
    bird = Bird(spriteImage);
    bird.updatePisition(150, 150);
    this..add(horizon)..add(bird);
  }

  @override
  void update(double t) {
    bird.update(t);
    // bird.x += t * 100;
  }
}
