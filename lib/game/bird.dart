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
  int _counter = 0;
  int _movingUpSteps = 15;
  Size _screenSize;
  double _heightDiff = 0.0;
  double _stepDiff = 0.0;

  BirdGround ground;
  BirdStatus status = BirdStatus.waiting;
  BirdFlyingStatus flyingStatus = BirdFlyingStatus.none;

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
    if (status == BirdStatus.flying) {
      _counter++;
      if (_counter <= _movingUpSteps) {
        flyingStatus = BirdFlyingStatus.up;
        this.ground.showAnimation = true;
        this.ground.angle -= 0.01;
        this.ground.y -= t * 100 * getSpeedRatio(flyingStatus, _counter);
      }
      else {
        flyingStatus = BirdFlyingStatus.down;
        this.ground.showAnimation = false;

        if (_heightDiff == 0)
          _heightDiff = (_screenSize.height - this.ground.y);
        if (_stepDiff == 0)
          _stepDiff = this.ground.angle.abs() / (_heightDiff / 10);
          
        this.ground.angle += _stepDiff;
        this.ground.y += t * 100 * getSpeedRatio(flyingStatus, _counter);
      }
      this.ground.update(t);
    }
  }

  double getSpeedRatio(BirdFlyingStatus flyingStatus, int counter){
    if (flyingStatus == BirdFlyingStatus.up) {
      var backwardCounter = _movingUpSteps - counter;
      return backwardCounter / 10.0;
    }
    if (flyingStatus == BirdFlyingStatus.down) {
      var diffCounter = counter - _movingUpSteps;
      return diffCounter / 10.0;
    }
    return 0.0;
  }

  void jump() {
    Flame.audio.play('wing.wav');
    status = BirdStatus.flying;
    _counter = 0;
    this.ground.angle = 0;
  }
}

class BirdGround extends AnimationComponent {
  bool showAnimation = true;
  
  BirdGround(Animation animation) 
    : super(ComponentDimensions.birdWidth, ComponentDimensions.birdHeight, animation);

  @override
  void update(double t){
    if (showAnimation) {
      super.update(t);
    }
  }
}