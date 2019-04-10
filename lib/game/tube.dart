import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/components/composed_component.dart';
import 'package:flame/components/resizable.dart';
import 'package:flame/sprite.dart';
import 'package:flutter_bird/game/config.dart';
import 'package:flutter_bird/main.dart';

enum TubeType { top, bottom }

class Tube extends PositionComponent with Resizable, ComposedComponent {
  TubeGround ground;
  TubeType _type;
  bool _hasBeenOnScreen = false;

  bool get isOnScreen => 
    this.ground.x + ComponentDimensions.tubeWidth > 0 && 
    this.ground.x < Singleton.instance.screenSize.width;

  Tube(TubeType type, Image spriteImage) {
    _type = type;
    var sprite = Sprite.fromImage(
      spriteImage,
      width: SpriteDimensions.tubeWidth,
      height: SpriteDimensions.tubeHeight,
      y: SpritesPostions.tubeY,
      x: SpritesPostions.tubeX,
    );

    this.ground = TubeGround(sprite, _type);

    switch (_type) {
      case TubeType.top:
        this.ground.angle = 3.14159; // radians
        break;
      default:
    }

    this..add(ground);
  }

  @override
  Rect toRect() {
    var baseRect = super.toRect();
    if (_type == TubeType.bottom) {
      return baseRect;
    }
    else {
      return Rect.fromLTWH(
        baseRect.left - ComponentDimensions.tubeWidth, 
        baseRect.top - ComponentDimensions.tubeHeight, 
        baseRect.width, 
        baseRect.height
      );
    }
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
      
      if (!_hasBeenOnScreen && isOnScreen)
        _hasBeenOnScreen = true;
      if (_hasBeenOnScreen && !isOnScreen)
      {
        print("Moved");
        this.ground.x = Singleton.instance.screenSize.width * 1.5;
        _hasBeenOnScreen = false;
      }

      this.ground.x -= t * 120;
  }
}

class TubeGround extends SpriteComponent with Resizable {
  TubeType _type;

  TubeGround(Sprite sprite, TubeType type)
      : super.fromSprite(
            ComponentDimensions.tubeWidth, ComponentDimensions.tubeHeight, sprite)
  {
    _type = type;
  }
  
  @override
  Rect toRect() {
    var baseRect = super.toRect();
    if (_type == TubeType.bottom) {
      return baseRect;
    }
    else {
      return Rect.fromLTWH(
        baseRect.left - ComponentDimensions.tubeWidth, 
        baseRect.top - ComponentDimensions.tubeHeight, 
        baseRect.width, 
        baseRect.height
      );
    }
  }
}