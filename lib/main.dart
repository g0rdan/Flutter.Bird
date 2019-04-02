import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bird/game/game.dart';

void main() async {
  Flame.audio.disableLog();
  var image = await Flame.images.loadAll(["sprite.png"]);
  var screenSize = await Flame.util.initialDimensions();
  var flutterBirdGame = FlutterBirdGame(spriteImage: image[0], screenSize: screenSize);
  runApp(MaterialApp(
    title: 'FlutterBirdGame',
    home: Scaffold(
      body: GameWrapper(flutterBirdGame),
    ),
  ));

  Flame.util.addGestureRecognizer(new TapGestureRecognizer()
    ..onTapDown = (TapDownDetails evt) => flutterBirdGame.onTap());

  SystemChrome.setEnabledSystemUIOverlays([]);
}

class GameWrapper extends StatelessWidget {
  final FlutterBirdGame tRexGame;
  GameWrapper(this.tRexGame);

  @override
  Widget build(BuildContext context) {
    return tRexGame.widget;
  }
}
