import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/components/composed_component.dart';
import 'package:flame/components/resizable.dart';
import 'package:flame/sprite.dart';
import 'package:flutter_bird/game/config.dart';

enum TubeType { top, bottom }

class Tube extends PositionComponent with Resizable, ComposedComponent {
  TubeGround _ground;
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

    this._ground = TubeGround(sprite);

    switch (_type) {
      case TubeType.top:
        this._ground.angle = 3.14159; // radians
        break;
      default:
    }

    this..add(_ground);
  }

  void setPosition(double x, double y) {
    this._ground.x = x;
    this._ground.y = _type == TubeType.top ? 
      y + ComponentDimensions.tubeHeight 
      : y;
  }
}

class TubeGround extends SpriteComponent with Resizable {
  TubeGround(Sprite sprite)
      : super.fromSprite(
            ComponentDimensions.tubeWidth, ComponentDimensions.tubeHeight, sprite);
}