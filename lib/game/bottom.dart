import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/components/composed_component.dart';
import 'package:flame/components/resizable.dart';
import 'package:flame/sprite.dart';
import 'package:flutter_bird/game/config.dart';

enum BottomStatus { waiting, moving }

class Bottom extends PositionComponent with ComposedComponent {
  BottomGround firstGround;
  BottomGround secondGround;
  BottomStatus status = BottomStatus.waiting;

  Size _screenSize;
  Rect _rect;
  Rect get rect => _rect;

  Bottom(Image spriteImage, Size screenSize) {
    _screenSize = screenSize;
    Sprite sprite = Sprite.fromImage(
      spriteImage,
      width: SpriteDimensions.bottomWidth,
      height: SpriteDimensions.bottomHeight,
      y: SpritesPostions.bottomY,
      x: SpritesPostions.bottomX,
    );

    this.firstGround = BottomGround(sprite, screenSize);
    this.secondGround = BottomGround(sprite, screenSize);
    this..add(firstGround)..add(secondGround);
  }

  void setPosition(double x, double y) {
    this.firstGround.x = x;
    this.firstGround.y = y;
    this.secondGround.x = this.firstGround.width;
    this.secondGround.y = y;
    _rect = Rect.fromLTWH(x, y, _screenSize.width, ComponentDimensions.bottomHeight);
  }

  void update(double t){
    if (status == BottomStatus.moving) {
      this.firstGround.x -= t * Speed.GroundSpeed;
      this.secondGround.x -= t * Speed.GroundSpeed;

      if (this.firstGround.x + this.firstGround.width <= 0) {
        this.firstGround.x = this.secondGround.x + this.secondGround.width;
      }

      if (this.secondGround.x + this.secondGround.width <= 0) {
        this.secondGround.x = this.firstGround.x + this.firstGround.width;
      }
    }
  }

  void move() {
    status = BottomStatus.moving;
  }
}

class BottomGround extends SpriteComponent with Resizable {
  BottomGround(Sprite sprite, Size screenSize)
      : super.fromSprite(
            screenSize.width, ComponentDimensions.bottomHeight, sprite);
}