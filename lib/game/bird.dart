import 'dart:ui';

import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/composed_component.dart';
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
        this.ground.y -= t * 100;  
        this.ground.angle -= 0.01;
      }
      else if (counter > tickStep && counter <= tickStep * 2) {
        counter++;
        flyingStatus = BirdFlyingStatus.down;
        this.ground.y += t * 100;  
        this.ground.angle += 0.01;
      }
      else{
        flyingStatus = BirdFlyingStatus.none;
        counter = 0;
      }
      
      this.ground.update(t);
    }
  }

  void jump() {
    status = BirdStatus.flying;
  }
}

class BirdGround extends AnimationComponent {
  BirdGround(Animation animation) : super(51, 36, animation);
}