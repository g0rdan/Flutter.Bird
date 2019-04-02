import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/components/composed_component.dart';
import 'package:flame/components/resizable.dart';
import 'package:flame/sprite.dart';
import 'package:flutter_bird/game/config.dart';

class Bottom extends PositionComponent with ComposedComponent {
  BottomGround ground;

  Bottom(Image spriteImage, Size screenSize) {
    Sprite sprite = Sprite.fromImage(
      spriteImage,
      width: SpriteDimensions.bottomWidth,
      height: SpriteDimensions.bottomHeight,
      y: SpritesPostions.bottomY,
      x: SpritesPostions.bottomX,
    );

    this.ground = BottomGround(sprite, screenSize);
    this..add(ground);
  }

  void setPosition(double x, double y) {
    this.ground.x = x;
    this.ground.y = y;
  }
}

class BottomGround extends SpriteComponent with Resizable {
  BottomGround(Sprite sprite, Size screenSize)
      : super.fromSprite(
            screenSize.width, ComponentDimensions.bottomHeight, sprite);
}