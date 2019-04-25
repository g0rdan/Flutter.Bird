import 'dart:math';
import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/components/composed_component.dart';
import 'package:flame/components/resizable.dart';
import 'package:flame/sprite.dart';
import 'package:flutter_bird/game/config.dart';
import 'package:flutter_bird/main.dart';

enum TubeType { top, bottom }

class Tube extends PositionComponent with Resizable, ComposedComponent {
  Tube _bottomTube;
  TubeGround ground;
  TubeType _type;
  bool _hasBeenOnScreen = false;
  double _holeRange = 150;
  double get _topTubeOffset => Singleton.instance.screenSize.height * 0.15;
  double get _bottomTubeOffset => Singleton.instance.screenSize.height * 0.5;

  bool get isOnScreen => 
    this.ground.x + ComponentDimensions.tubeWidth > 0 && 
    this.ground.x < Singleton.instance.screenSize.width;
  
  bool crossedBird = false;

  Tube(TubeType type, Image spriteImage, [Tube bottomTube]) {
    _type = type;
    _bottomTube = bottomTube;
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
    _hasBeenOnScreen = false;
    crossedBird = false;
    this.ground.x = x + (_type == TubeType.top ? ComponentDimensions.tubeWidth : 0);
    setY();
  }

  void update(double t){
      if (!_hasBeenOnScreen && isOnScreen)
        _hasBeenOnScreen = true;
      if (_hasBeenOnScreen && !isOnScreen)
      {
        print("Moved");
        this.ground.x = Singleton.instance.screenSize.width * 1.5;
        setY();
        crossedBird = false;
        _hasBeenOnScreen = false;
      }
      this.ground.x -= t * Speed.GroundSpeed;
  }

  void setY() {
    var ratio = double.parse(Random().nextDouble().toStringAsFixed(2));
    var length = _bottomTubeOffset - _topTubeOffset;
    var newY = length * ratio + _topTubeOffset;
    this.ground.y = newY;
    if (_bottomTube != null) {
      _bottomTube.ground.y = newY + _holeRange;
    }
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