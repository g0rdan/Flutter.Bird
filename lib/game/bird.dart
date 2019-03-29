import 'dart:ui';

import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/composed_component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter_bird/game/config.dart';

class Bird extends PositionComponent with ComposedComponent {
  BirdGround ground;

  Bird(Image spriteImage)
  {
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
    this.ground = BirdGround(animatedBird);
    this..add(ground);
  }

  void updatePisition(double x, double y) {
    this.ground.x = x;
    this.ground.y = y;
  }
}

class BirdGround extends AnimationComponent {
  BirdGround(Animation animation) : super(51, 36, animation);
}