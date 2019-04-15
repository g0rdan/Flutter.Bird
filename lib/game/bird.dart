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
  int tickStep = 15;
  Size _screenSize;
  double heightDiff = 0.0;
  double stepDiff = 0.0;

  Bird(Image spriteImage, Size screenSize)
  {
    _screenSize = screenSize;
    List<Sprite> sprites = [
      Sprite.fromImage(
        spriteImage,
        width: SpriteDimensions.birdWidth,
        height: SpriteDimensions.birdHeight,
        y: SpritesPostions.birdSprite1Y,
        x: SpritesPostions.birdSprite1X,
      ),
      Sprite.fromImage(
        spriteImage,
        width: SpriteDimensions.birdWidth,
        height: SpriteDimensions.birdHeight,
        y: SpritesPostions.birdSprite2Y,
        x: SpritesPostions.birdSprite2X,
      ),
      Sprite.fromImage(
        spriteImage,
        width: SpriteDimensions.birdWidth,
        height: SpriteDimensions.birdHeight,
        y: SpritesPostions.birdSprite3Y,
        x: SpritesPostions.birdSprite3X,
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

  double getSpeedRatio(BirdFlyingStatus flyingStatus, int counter){
    if (flyingStatus == BirdFlyingStatus.up) {
      var backwardCounter = tickStep - counter;
      return backwardCounter / 10.0;
    }
    if (flyingStatus == BirdFlyingStatus.down) {
      var diffCounter = counter - tickStep;
      return diffCounter / 10.0;
    }
    return 0.0;
  }

  void birdMovingProcess(double t){
    if (status == BirdStatus.flying) {
      counter++;
      if (counter <= tickStep) {
        flyingStatus = BirdFlyingStatus.up;
        this.ground.showAnimation = true;
        this.ground.angle -= 0.01;
        this.ground.y -= t * 100 * getSpeedRatio(flyingStatus, counter);
      }
      else {
        flyingStatus = BirdFlyingStatus.down;
        this.ground.showAnimation = false;

        if (heightDiff == 0)
          heightDiff = (_screenSize.height - this.ground.y);
        if (stepDiff == 0)
          stepDiff = this.ground.angle.abs() / (heightDiff / 10);
          
        this.ground.angle += stepDiff;
        this.ground.y += t * 100 * getSpeedRatio(flyingStatus, counter);
      }
      
      this.ground.update(t);
    }
  }

  void jump() {
    Flame.audio.play('wing.wav');
    status = BirdStatus.flying;
    counter = 0;
    this.ground.angle = 0;
  }
}

class BirdGround extends AnimationComponent {

  bool _showAnimation = true;
  bool get showAnimation => _showAnimation;
  set showAnimation(bool value) => _showAnimation = value;

  BirdGround(Animation animation) : super(51, 36, animation);

  @override
  void update(double t){
    if (_showAnimation) {
      super.update(t);
    }
  }
}