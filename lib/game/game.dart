import 'dart:ui';
import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter_bird/game/config.dart';
import 'package:flutter_bird/game/horizont.dart';

enum FlutterBirdGameStatus { playing, waiting, gameOver }

class FlutterBirdGame extends BaseGame {
  Horizon horizon;
  AnimationComponent anim;
  // Bird bird;
  FlutterBirdGameStatus status = FlutterBirdGameStatus.waiting;

  double timePlaying = 0.0;

  FlutterBirdGame({Image spriteImage}) {

    horizon = new Horizon(spriteImage);

    List<Sprite> sprites = [
      Sprite.fromImage(
        spriteImage,
        width: Dimensions.birdWidth,
        height: Dimensions.birdHeight,
        y: 491.0,
        x: 3.0,
      ),
      Sprite.fromImage(
        spriteImage,
        width: Dimensions.birdWidth,
        height: Dimensions.birdHeight,
        y: 491.0,
        x: 31.0,
      ),
      Sprite.fromImage(
        spriteImage,
        width: Dimensions.birdWidth,
        height: Dimensions.birdHeight,
        y: 491.0,
        x: 59.0,
      )
    ];

    var animatedBird = new Animation.spriteList(sprites, stepTime: 0.15);
    anim = AnimationComponent((51), 36, animatedBird);
    anim.x = 150;
    anim.y = 150;
    
    this..add(horizon)..add(anim);
  }

  @override
  void update(double t) {
    anim.update(t);
  }

  bool get playing => status == FlutterBirdGameStatus.playing;
  bool get gameOver => status == FlutterBirdGameStatus.gameOver;
}
