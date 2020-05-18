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
    _renderDefaultView();
    }
      
  void increase() {
    _score++;
    _render();
    Flame.audio.play('point.wav');
  }

  void reset() {
    _score = 0;
    _render();
  }

  void _render(){
    // Adds leading zeroes to 3 digits
    var scoreStr = _score.toString().padLeft(3, '0');
    _oneDigitGround.sprite = _digits[scoreStr[2]];
    _twoDigitGround.sprite = _digits[scoreStr[1]];
    _threeDigitGround.sprite = _digits[scoreStr[0]];
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

  void _renderDefaultView() {
    double defaultY = 80;
    var twoGroundX = (_screenSize.width - ComponentDimensions.numberWidth) / 2;
    _twoDigitGround = ScorerGround(_digits["0"]);
    this._twoDigitGround.x = twoGroundX;
    this._twoDigitGround.y = defaultY;
    _oneDigitGround = ScorerGround(_digits["0"]);
    this._oneDigitGround.x = _twoDigitGround.toRect().right + 5;
    this._oneDigitGround.y = defaultY;
    _threeDigitGround = ScorerGround(_digits["0"]);
    this._threeDigitGround.x = twoGroundX - ComponentDimensions.numberWidth - 5;
    this._threeDigitGround.y = defaultY;
    this..add(_oneDigitGround)..add(_twoDigitGround)..add(_threeDigitGround);
  }
}

class ScorerGround extends SpriteComponent with Resizable {
  ScorerGround(Sprite sprite, [int multiplier = 1])
      : super.fromSprite(
            ComponentDimensions.numberWidth * multiplier, ComponentDimensions.numberHeight, sprite);
}