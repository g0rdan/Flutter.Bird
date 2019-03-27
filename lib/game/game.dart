import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flutter_bird/game/game_config.dart';
import 'package:flutter_bird/game/horizont.dart';
// import 'package:trex/game/Horizon/horizon.dart';
// import 'package:trex/game/collision/collision_utils.dart';
// import 'package:trex/game/game_config.dart';
// import 'package:trex/game/game_over/game_over.dart';
// import 'package:trex/game/t_rex/config.dart';
// import 'package:trex/game/t_rex/t_rex.dart';

enum FlutterBirdGameStatus { playing, waiting, gameOver }

class FlutterBirdGame extends BaseGame {
  // TRex tRex;
  Horizon horizon;
  // GameOverPanel gameOverPanel;
  FlutterBirdGameStatus status = FlutterBirdGameStatus.waiting;

  double currentSpeed = GameConfig.speed;
  double timePlaying = 0.0;

  FlutterBirdGame({Image spriteImage}) {
    // tRex = new TRex(spriteImage);
    horizon = new Horizon(spriteImage);
    // gameOverPanel = new GameOverPanel(spriteImage);

    this..add(horizon);
  }

  void onTap() {
    if (gameOver) {
      return;
    }
  }

  @override
  void update(double t) {
    // timePlaying += t;
    // horizon.updateWithSpeed(0.0, this.currentSpeed);
  }

  bool get playing => status == FlutterBirdGameStatus.playing;
  bool get gameOver => status == FlutterBirdGameStatus.gameOver;
}
