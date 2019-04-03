import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flutter_bird/game/bird.dart';
import 'package:flutter_bird/game/bottom.dart';
import 'package:flutter_bird/game/config.dart';
import 'package:flutter_bird/game/horizont.dart';

class FlutterBirdGame extends BaseGame {
  Size screenSize;
  Horizon horizon;
  Bird bird;
  Bottom bottom; 

  FlutterBirdGame({Image spriteImage, Size screenSize}) {
    horizon = Horizon(spriteImage, screenSize);
    bird = Bird(spriteImage);
    bottom = Bottom(spriteImage, screenSize);
    bird.setPosition(ComponentPositions.birdX, ComponentPositions.birdY);
    bottom.setPosition(0, screenSize.height - ComponentDimensions.bottomHeight);
    this..add(horizon)..add(bird)..add(bottom);
  }

  @override
  void update(double t) {
    bird.update(t);
    bottom.update(t);
  }

  void onTap() {
    bird.jump();
    bottom.move();
  }
}
