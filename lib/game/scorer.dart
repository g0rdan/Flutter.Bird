import 'dart:collection';
import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/components/composed_component.dart';
import 'package:flame/components/resizable.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'config.dart';

class Scorer extends PositionComponent with ComposedComponent {
  int _score = 0;
  Size _screenSize;
  HashMap<String, Sprite> _digits;
  ScorerGround _oneDigitGround;
  ScorerGround _twoDigitGround;
  ScorerGround _threeDigitGround;

  Scorer(Image spriteImage, Size screenSize){
    _screenSize = screenSize;
    _initSprites(spriteImage);

    _oneDigitGround = ScorerGround(_digits["0"]);
    this._oneDigitGround.x = (screenSize.width - ComponentDimensions.numberWidth) / 2;
    this._oneDigitGround.y = 80;
    this..add(_oneDigitGround);
  }
  
  void increase() {
    _score++;
    _render();
    Flame.audio.play('point.wav');
  }

  void _render(){
    var scoreStr = _score.toString();
    switch (scoreStr.length) {
      case 1:
        _renderOneDigitScore(_score);
        break;
      case 2:
        _renderTwoDigitScore(_score);
        break;
      case 3:
        _renderThreeDigitScore(_score);
        break;
      default:
        _removeScore();
    }
  }

  void _renderOneDigitScore([int score]){
    _oneDigitGround.sprite = _digits[score.toString()];
  }

  void _renderTwoDigitScore([int score]){
  }

  void _renderThreeDigitScore([int score]){
  }

  void _removeScore(){
  }

  void _initSprites(Image spriteImage){
    _digits = HashMap.from({
      "0": Sprite.fromImage(
        spriteImage,
        width: SpriteDimensions.numberWidth,
        height: SpriteDimensions.numberHeight,
        x: SpritesPostions.zeroNumberX,
        y: SpritesPostions.zeroNumberY,
      ), 
      "1": Sprite.fromImage(
        spriteImage,
        width: SpriteDimensions.numberWidth,
        height: SpriteDimensions.numberHeight,
        x: SpritesPostions.firstNumberX,
        y: SpritesPostions.firstNumberY,
      ),
      "2": Sprite.fromImage(
        spriteImage,
        width: SpriteDimensions.numberWidth,
        height: SpriteDimensions.numberHeight,
        x: SpritesPostions.secondNumberX,
        y: SpritesPostions.secondNumberY,
      ),
      "3": Sprite.fromImage(
        spriteImage,
        width: SpriteDimensions.numberWidth,
        height: SpriteDimensions.numberHeight,
        x: SpritesPostions.thirdNumberX,
        y: SpritesPostions.thirdNumberY,
      ),
      "4": Sprite.fromImage(
        spriteImage,
        width: SpriteDimensions.numberWidth,
        height: SpriteDimensions.numberHeight,
        x: SpritesPostions.fourthNumberX,
        y: SpritesPostions.fourthNumberY,
      ),
      "5": Sprite.fromImage(
        spriteImage,
        width: SpriteDimensions.numberWidth,
        height: SpriteDimensions.numberHeight,
        x: SpritesPostions.fifthNumberX,
        y: SpritesPostions.fifthNumberY,
      ),
      "6": Sprite.fromImage(
        spriteImage,
        width: SpriteDimensions.numberWidth,
        height: SpriteDimensions.numberHeight,
        x: SpritesPostions.sixthNumberX,
        y: SpritesPostions.sixthNumberY,
      ),
      "7": Sprite.fromImage(
        spriteImage,
        width: SpriteDimensions.numberWidth,
        height: SpriteDimensions.numberHeight,
        x: SpritesPostions.seventhNumberX,
        y: SpritesPostions.seventhNumberY,
      ),
      "8": Sprite.fromImage(
        spriteImage,
        width: SpriteDimensions.numberWidth,
        height: SpriteDimensions.numberHeight,
        x: SpritesPostions.eighthNumberX,
        y: SpritesPostions.eighthNumberY,
      ),
      "9": Sprite.fromImage(
        spriteImage,
        width: SpriteDimensions.numberWidth,
        height: SpriteDimensions.numberHeight,
        x: SpritesPostions.ninethNumberX,
        y: SpritesPostions.ninethNumberY,
      )
    });
  }
}

class ScorerGround extends SpriteComponent with Resizable {
  ScorerGround(Sprite sprite, [int multiplier = 1])
      : super.fromSprite(
            ComponentDimensions.numberWidth * multiplier, ComponentDimensions.numberHeight, sprite);
}