import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flutter_bird/game/bird.dart';
import 'package:flutter_bird/game/bottom.dart';
import 'package:flutter_bird/game/config.dart';
import 'package:flutter_bird/game/gameover.dart';
import 'package:flutter_bird/game/horizont.dart';
import 'package:flutter_bird/game/tube.dart';

enum GameStatus { playing, waiting, gameOver }

class FlutterBirdGame extends BaseGame {
  Size screenSize;
  Horizon horizon;
  Bird bird;
  Bottom bottom;
  GameOver gameOver;
  Tube topTube;
  Tube bottomTube;
  GameStatus status = GameStatus.waiting;
  double speed = 1.0;

  FlutterBirdGame({Image spriteImage, Size screenSize}) {
    horizon = Horizon(spriteImage, screenSize);
    bird = Bird(spriteImage);
    bottom = Bottom(spriteImage, screenSize);
    gameOver = GameOver(spriteImage, screenSize);
    topTube = Tube(TubeType.top, spriteImage);
    bottomTube = Tube(TubeType.bottom, spriteImage);
    bird.setPosition(ComponentPositions.birdX, ComponentPositions.birdY);
    bottom.setPosition(0, screenSize.height - ComponentDimensions.bottomHeight);
    bottomTube.setPosition(480, 150);
    this..add(horizon)..add(bird)..add(bottomTube)..add(bottom);
  }

  @override
  void update(double t) {
    if (status == GameStatus.playing) {
      bird.update(t * speed);
      bottom.update(t * speed);
      bottomTube.update(t * speed);
    }

    var birdRect = bird.ground.toRect();

    if (checkCollision(birdRect, bottom.rect)){
      status = GameStatus.gameOver;
      this..add(gameOver);
    }

    if (checkCollision(birdRect, bottomTube.ground.toRect())){
      status = GameStatus.gameOver;
      this..add(gameOver);
    }
  }

  void onTap() {
    status = GameStatus.playing;
    bird.jump();
    bottom.move();
  }

  bool checkCollision(Rect item1, Rect item2){
    var intersectedRect = item1.intersect(item2);
    return intersectedRect.width > 0 && intersectedRect.height > 0;
  }
}
