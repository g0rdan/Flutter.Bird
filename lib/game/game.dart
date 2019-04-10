import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flutter_bird/game/bird.dart';
import 'package:flutter_bird/game/bottom.dart';
import 'package:flutter_bird/game/config.dart';
import 'package:flutter_bird/game/gameover.dart';
import 'package:flutter_bird/game/horizont.dart';
import 'package:flutter_bird/game/tube.dart';
import 'package:flutter_bird/main.dart';

enum GameStatus { playing, waiting, gameOver }

class FlutterBirdGame extends BaseGame {
  Size screenSize;
  Horizon horizon;
  Bird bird;
  Bottom bottom;
  GameOver gameOver;
  Tube firstTopTube;
  Tube firstBottomTube;
  Tube secondTopTube;
  Tube secondBottomTube;
  Tube thirdTopTube;
  Tube thirdBottomTube;
  Image _spriteImage;
  GameStatus status = GameStatus.waiting;
  double speed = 1.0;
  double xTubeOffset = 210;
  double xTubeStart = Singleton.instance.screenSize.width * 1.5;

  FlutterBirdGame(Image spriteImage, Size screenSize) {
    _spriteImage = spriteImage;
    horizon = Horizon(spriteImage, screenSize);
    bird = Bird(spriteImage, screenSize);
    bottom = Bottom(spriteImage, screenSize);
    gameOver = GameOver(spriteImage, screenSize);

    firstBottomTube = Tube(TubeType.bottom, spriteImage);
    firstTopTube = Tube(TubeType.top, spriteImage, firstBottomTube);
    secondBottomTube = Tube(TubeType.bottom, spriteImage);
    secondTopTube = Tube(TubeType.top, spriteImage, secondBottomTube);
    thirdBottomTube = Tube(TubeType.bottom, spriteImage);
    thirdTopTube = Tube(TubeType.top, spriteImage, thirdBottomTube);

    initPositions(spriteImage);

    this
      ..add(horizon)
      ..add(bird)
      ..add(firstTopTube)
      ..add(firstBottomTube)
      ..add(secondTopTube)
      ..add(secondBottomTube)
      ..add(thirdTopTube)
      ..add(thirdBottomTube)
      ..add(bottom);
  }

  void initPositions(Image spriteImage) {
    bird.setPosition(ComponentPositions.birdX, ComponentPositions.birdY);
    bottom.setPosition(0, Singleton.instance.screenSize.height - ComponentDimensions.bottomHeight);
    firstBottomTube.setPosition(xTubeStart, 400);
    firstTopTube.setPosition(xTubeStart, -250);
    secondBottomTube.setPosition(xTubeStart + xTubeOffset, 400);
    secondTopTube.setPosition(xTubeStart + xTubeOffset, -250);
    thirdBottomTube.setPosition(xTubeStart + xTubeOffset * 2, 400);
    thirdTopTube.setPosition(xTubeStart + xTubeOffset * 2, -250);
  }

  @override
  void update(double t) {
    if (status == GameStatus.playing) {
      bird.update(t * speed);
      bottom.update(t * speed);
      firstBottomTube.update(t * speed);
      firstTopTube.update(t * speed);
      secondBottomTube.update(t * speed);
      secondTopTube.update(t * speed);
      thirdBottomTube.update(t * speed);
      thirdTopTube.update(t * speed);
    }

    var birdRect = bird.ground.toRect();

    if (checkCollision(birdRect, bottom.rect)){
      status = GameStatus.gameOver;
      this..add(gameOver);
    }

    // if (checkCollision(birdRect, firstBottomTube.ground.toRect())){
    //   status = GameStatus.gameOver;
    //   this..add(gameOver);
    // }

    // if (checkCollision(birdRect, firstTopTube.ground.toRect())){
    //   status = GameStatus.gameOver;
    //   this..add(gameOver);
    // }

    // if (checkCollision(birdRect, secondBottomTube.ground.toRect())){
    //   status = GameStatus.gameOver;
    //   this..add(gameOver);
    // }

    // if (checkCollision(birdRect, secondTopTube.ground.toRect())){
    //   status = GameStatus.gameOver;
    //   this..add(gameOver);
    // }

    // if (checkCollision(birdRect, thirdBottomTube.ground.toRect())){
    //   status = GameStatus.gameOver;
    //   this..add(gameOver);
    // }

    // if (checkCollision(birdRect, thirdTopTube.ground.toRect())){
    //   status = GameStatus.gameOver;
    //   this..add(gameOver);
    // }
  }

  void onTap() {
    switch (status) {
      case GameStatus.waiting:
        status = GameStatus.playing;
        bird.jump();
        bottom.move();
        break;
      case GameStatus.gameOver:
        status = GameStatus.waiting;
        initPositions(_spriteImage);
        break;
      case GameStatus.playing:
        bird.jump();
        break;
      default:
    }
    
  }

  bool checkCollision(Rect item1, Rect item2){
    var intersectedRect = item1.intersect(item2);
    return intersectedRect.width > 0 && intersectedRect.height > 0;
  }
}
