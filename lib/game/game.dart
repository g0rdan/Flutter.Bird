import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter_bird/game/bird.dart';
import 'package:flutter_bird/game/bottom.dart';
import 'package:flutter_bird/game/config.dart';
import 'package:flutter_bird/game/gameover.dart';
import 'package:flutter_bird/game/horizont.dart';
import 'package:flutter_bird/game/scorer.dart';
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
  Scorer _scorer;
  GameStatus status = GameStatus.waiting;
  double xTubeOffset = 220;
  double xTubeStart = Singleton.instance.screenSize.width * 1.5;

  FlutterBirdGame(Image spriteImage, Size screenSize) {
    _spriteImage = spriteImage;
    horizon = Horizon(spriteImage, screenSize);
    bird = Bird(spriteImage, screenSize);
    bottom = Bottom(spriteImage, screenSize);
    gameOver = GameOver(spriteImage, screenSize);
    _scorer = Scorer(spriteImage, screenSize);

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
      ..add(bottom)
      ..add(gameOver)
      ..add(_scorer);
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
    gameOver.ground.y = Singleton.instance.screenSize.height;
  }

  @override
  void update(double t) {
    if (status != GameStatus.playing)
      return;

    bird.update(t * Speed.GameSpeed);
    bottom.update(t * Speed.GameSpeed);
    firstBottomTube.update(t * Speed.GameSpeed);
    firstTopTube.update(t * Speed.GameSpeed);
    secondBottomTube.update(t * Speed.GameSpeed);
    secondTopTube.update(t * Speed.GameSpeed);
    thirdBottomTube.update(t * Speed.GameSpeed);
    thirdTopTube.update(t * Speed.GameSpeed);

    var birdRect = bird.ground.toRect();

    if (check2ItemsCollision(birdRect, bottom.rect)){
      gameOverAction();
    }

    if (check2ItemsCollision(birdRect, firstBottomTube.ground.toRect())){
      gameOverAction();
    }

    if (check2ItemsCollision(birdRect, firstTopTube.ground.toRect())){
      gameOverAction();
    }

    if (check2ItemsCollision(birdRect, secondBottomTube.ground.toRect())){
      gameOverAction();
    }

    if (check2ItemsCollision(birdRect, secondTopTube.ground.toRect())){
      gameOverAction();
    }

    if (check2ItemsCollision(birdRect, thirdBottomTube.ground.toRect())){
      gameOverAction();
    }

    if (check2ItemsCollision(birdRect, thirdTopTube.ground.toRect())){
      gameOverAction();
    }

    if (checkIfBirdCrossedTube(firstTopTube) || 
        checkIfBirdCrossedTube(secondTopTube) || 
        checkIfBirdCrossedTube(thirdTopTube)) {
      _scorer.increase();
    }
  }

  void gameOverAction(){
    if (status != GameStatus.gameOver) {
      Flame.audio.play('hit.wav');
      Flame.audio.play('die.wav');
      status = GameStatus.gameOver;
      gameOver.ground.y = (Singleton.instance.screenSize.height - gameOver.ground.height) / 2;
    }
  }

  bool checkIfBirdCrossedTube(Tube tube) {
    if (!tube.crossedBird) {
      var tubeRect = tube.ground.toRect();
      var xCenterOfTube = tubeRect.left + tubeRect.width / 2;
      var xCenterOfBird = ComponentPositions.birdX + ComponentDimensions.birdWidth / 2;
      if (xCenterOfTube < xCenterOfBird && status == GameStatus.playing) {
        tube.crossedBird = true;
        return true;
      }
    }
    return false;
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
        _scorer.reset();
        break;
      case GameStatus.playing:
        bird.jump();
        break;
      default:
    }
    
  }

  bool check2ItemsCollision(Rect item1, Rect item2){
    var intersectedRect = item1.intersect(item2);
    return intersectedRect.width > 0 && intersectedRect.height > 0;
  }
}