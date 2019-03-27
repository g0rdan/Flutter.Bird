import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/components/resizable.dart';

import 'package:flame/components/composed_component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter_bird/game/horizont_config.dart';

class Horizon extends PositionComponent with Resizable, ComposedComponent {
  
  HorizonGround ground;

  Horizon(Image spriteImage) {
    Sprite sprite = Sprite.fromImage(
      spriteImage,
      width: HorizonDimensions.width,
      height: HorizonDimensions.height,
      y: 104.0,
      x: 2.0,
    );

    this.ground = HorizonGround(sprite);
    this..add(ground);
  }
}

class HorizonGround extends SpriteComponent with Resizable {
  HorizonGround(Sprite sprite)
      : super.fromSprite(
            HorizonDimensions.width, HorizonDimensions.height, sprite);
}