import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/components/composed_component.dart';
import 'package:flame/components/resizable.dart';
import 'package:flame/sprite.dart';
import 'package:flutter_bird/game/config.dart';

class GameOver extends PositionComponent with ComposedComponent {
  GameOverGround _gameOverGround;

  GameOver(Image spriteImage, Size screenSize){
    var sprite = Sprite.fromImage(
      spriteImage,
      width: SpriteDimensions.gameOverWidth,
      height: SpriteDimensions.gameOverHeight,
      y: SpritesPostions.gameOverY,
      x: SpritesPostions.gameOverX,
    );
    
    this._gameOverGround = GameOverGround(sprite);
    this._gameOverGround.x = (screenSize.width - ComponentDimensions.gameOverWidth) / 2;
    this._gameOverGround.y = (screenSize.height - ComponentDimensions.gameOverHeight) / 2;
    this..add(_gameOverGround);
  }
}

class GameOverGround extends SpriteComponent with Resizable {
  GameOverGround(Sprite sprite)
      : super.fromSprite(
            ComponentDimensions.gameOverWidth, ComponentDimensions.gameOverHeight, sprite);
}