import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/components/resizable.dart';

import 'package:flame/components/composed_component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter_bird/game/config.dart';

class Horizon extends PositionComponent with Resizable, ComposedComponent {
  HorizonGround ground;

  Horizon(Image spriteImage, Size screenSize) {
    Sprite sprite = Sprite.fromImage(
      spriteImage,
      width: SpriteDimensions.horizontWidth,
      height: SpriteDimensions.horizontHeight,
      y: 0.0,
      x: 0.0,
    );

    this.ground = HorizonGround(sprite, screenSize);
    this..add(ground);
  }
}

class HorizonGround extends SpriteComponent with Resizable {
  HorizonGround(Sprite sprite, Size screenSize)
      : super.fromSprite(
            screenSize.width, screenSize.height, sprite);
}