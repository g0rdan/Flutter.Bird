import 'dart:ui';

import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/composed_component.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter_bird/game/config.dart';

enum BirdStatus { waiting, flying}
enum BirdFlyingStatus { up, down, none }

class Bird extends PositionComponent with ComposedComponent {
  BirdGround ground;
  BirdStatus status = BirdStatus.waiting;
  BirdFlyingStatus flyingStatus = BirdFlyingStatus.none;
  int counter = 0;
  int tickStep = 50;
  Size screenSize;
  double heightDiff = 0.0;
  double stepDiff = 0.0;

  Bird(Image spriteImage)
  {
    List<Sprite> sprites = [
      Sprite.fromImage(
        spriteImage,
        width: Dimensions.birdWidth,
        height: Dimensions.birdHeight,
        y: SpritesPostion.birdSprite1Y,
        x: SpritesPostion.birdSprite1X,
      ),
      Sprite.fromImage(
        spriteImage,
        width: Dimensions.birdWidth,
        height: Dimensions.birdHeight,
        y: SpritesPostion.birdSprite2Y,
        x: SpritesPostion.birdSprite2X,
      ),
      Sprite.fromImage(
        spriteImage,
        width: Dimensions.birdWidth,
        height: Dimensions.birdHeight,
        y: SpritesPostion.birdSprite3Y,
        x: SpritesPostion.birdSprite3X,
      )
    ];

    var animatedBird = new Animation.spriteList(sprites, stepTime: 0.15);
    this.ground = BirdGround(animatedBird);
    this..add(ground);
  }

  void setPosition(double x, double y) {
    this.ground.x = x;
    this.ground.y = y;
  }

  void update(double t) {
    birdMovingProcess(t);
  }

  void birdMovingProcess(double t){
    if (status == BirdStatus.flying) {
      if (counter <= tickStep) {
        counter++;
        flyingStatus = BirdFlyingStatus.up;
        this.ground.angle -= 0.01;
        this.ground.y -= 3;
      }
      else {
        flyingStatus = BirdFlyingStatus.down;

        if (heightDiff == 0)
          heightDiff = (screenSize.height - this.ground.y);
        if (stepDiff == 0)
          stepDiff = this.ground.angle.abs() / (heightDiff / 10);
          
        this.ground.angle += stepDiff;
        this.ground.y += 3;
      }
      // else{
      //   flyingStatus = BirdFlyingStatus.none;
      //   status = BirdStatus.waiting;
      //   counter = 0;
      // }
      this.ground.update(t);
    }
  }

  Future<void> jump() async {
    if (screenSize == null) {
      screenSize = await Flame.util.initialDimensions();
    }
    status = BirdStatus.flying;
    counter = 0;
  }
}

class BirdGround extends AnimationComponent {
  BirdGround(Animation animation) : super(51, 36, animation);
}