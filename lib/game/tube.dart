import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/components/composed_component.dart';
import 'package:flame/components/resizable.dart';
import 'package:flame/sprite.dart';
import 'package:flutter_bird/game/config.dart';

enum TubeType { top, bottom }

class Tube extends PositionComponent with Resizable, ComposedComponent {
  TubeGround ground;
  TubeType _type;

  Tube(TubeType type, Image spriteImage) {
    _type = type;
    var sprite = Sprite.fromImage(
      spriteImage,
      width: SpriteDimensions.tubeWidth,
      height: SpriteDimensions.tubeHeight,
      y: SpritesPostions.tubeY,
      x: SpritesPostions.tubeX,
    );

    this.ground = TubeGround(sprite);

    switch (_type) {
      case TubeType.top:
        this.ground.angle = 3.14159; // radians
        break;
      default:
    }

    this..add(ground);
  }

  void setPosition(double x, double y) {
    switch (_type) {
      case TubeType.top:
        this.ground.x = x + ComponentDimensions.tubeWidth;
        this.ground.y = y + ComponentDimensions.tubeHeight;
        break;
      default:
        this.ground.x = x;
        this.ground.y = y;
    }
  }

  void update(double t){
      this.ground.x -= t * 120;
  }
}

class TubeGround extends SpriteComponent with Resizable {
  TubeGround(Sprite sprite)
      : super.fromSprite(
            ComponentDimensions.tubeWidth, ComponentDimensions.tubeHeight, sprite);
}