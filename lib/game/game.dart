import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flutter_bird/game/bird.dart';
import 'package:flutter_bird/game/horizont.dart';

enum FlutterBirdGameStatus { playing, waiting, gameOver }

class FlutterBirdGame extends BaseGame {
  Horizon horizon;
  Bird bird;
  FlutterBirdGameStatus status = FlutterBirdGameStatus.waiting;

  double timePlaying = 0.0;

  FlutterBirdGame({Image spriteImage}) {
    horizon = new Horizon(spriteImage);
    bird = new Bird(spriteImage);
    this..add(horizon)..add(bird);

  }

  @override
  void update(double t) {
    // timePlaying += t;
    // horizon.updateWithSpeed(0.0, this.currentSpeed);
  }

  bool get playing => status == FlutterBirdGameStatus.playing;
  bool get gameOver => status == FlutterBirdGameStatus.gameOver;
}
