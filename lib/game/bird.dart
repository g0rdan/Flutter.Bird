import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/components/composed_component.dart';
import 'package:flame/components/resizable.dart';
import 'package:flame/sprite.dart';
import 'package:flutter_bird/game/config.dart';

class Bird extends PositionComponent with Resizable, ComposedComponent {
  BirdGround bird;

  Bird(Image spriteImage) {
    Sprite sprite = Sprite.fromImage(
      spriteImage,
      width: Dimensions.birdWidth,
      height: Dimensions.birdHeight,
      y: 491.0,
      x: 3.0,
    );

    this.bird = BirdGround(sprite);
    this.bird.x = 100;
    this.bird.y = 100;
    this..add(bird);
  }
}

class BirdGround extends SpriteComponent with Resizable {
  BirdGround(Sprite sprite)
      : super.fromSprite(
            51, 36, sprite);
}