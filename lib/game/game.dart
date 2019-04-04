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

  FlutterBirdGame({Image spriteImage, Size screenSize}) {
    horizon = Horizon(spriteImage, screenSize);
    bird = Bird(spriteImage);
    bottom = Bottom(spriteImage, screenSize);
    gameOver = GameOver(spriteImage, screenSize);
    topTube = Tube(TubeType.top, spriteImage);
    bottomTube = Tube(TubeType.bottom, spriteImage);
    bird.setPosition(ComponentPositions.birdX, ComponentPositions.birdY);
    bottom.setPosition(0, screenSize.height - ComponentDimensions.bottomHeight);
    this..add(horizon)..add(bird)..add(bottom);

    topTube.setPosition(100, 100);
    bottomTube.setPosition(178, 100);
    this..add(topTube)..add(bottomTube);
  }

  @override
  void update(double t) {
    if (status == GameStatus.playing) {
      bird.update(t);
      bottom.update(t);
    }
    if (checkCollision(bird.ground.toRect(), bottom.rect)){
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
