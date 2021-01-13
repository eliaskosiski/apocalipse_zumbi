import 'dart:ui';
import 'package:apocalipse_zumbi/view.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:apocalipse_zumbi/components/zumbis.dart';
import 'package:apocalipse_zumbi/components/zumbi.dart';
import 'package:apocalipse_zumbi/components/backyard.dart';
import 'package:apocalipse_zumbi/components/start-button.dart';
import 'package:apocalipse_zumbi/controllers/spawner.dart';

class MyGame extends Game {
  Size screenSize;
  double tileSize;
  List<Zumbis> flies;
  Random rnd;
  double x, y;
  ZumbiSpawner spawner;

  int score;

  Backyard background;

  View activeView = View.home;

  StartButton startButton;

  MyGame() {
    initialize();
  }

  void initialize() async {
    flies = List<Zumbis>();
    rnd = Random();
    score = 0;
    resize(await Flame.util.initialDimensions());

    spawner = ZumbiSpawner(this);

    startButton = StartButton(this);

    background = Backyard(this);
  }

  void spawnFly() {
    x = rnd.nextDouble() * (screenSize.width - tileSize);
    y = rnd.nextDouble() * (screenSize.height - tileSize);
    {
      flies.add(Terra(this, x, y));
    }
  }

  void render(Canvas canvas) {
    background.render(canvas);

    if (activeView == View.home || activeView == View.lost) {
      startButton.render(canvas);
    }

    flies.forEach((Zumbis zumbis) => zumbis.render(canvas));
  }

  void update(double t) {
    spawner.update(t);
    flies.forEach((Zumbis zumbis) => zumbis.update(t));
    flies.removeWhere((Zumbis zumbis) => zumbis.isOffScreen);
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
  }

  void onTapDown(TapDownDetails d) {
    bool isHandled = false;
    bool didHitAFly = false;

    if (!isHandled && startButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        startButton.onTapDown();
        isHandled = true;
        didHitAFly = true;
      }
    }
    if (!isHandled) {
      flies.forEach((Zumbis zumbis) {
        if (zumbis.zumbiRect.contains(d.globalPosition)) {
          zumbis.onTapDown();
          isHandled = true;
          didHitAFly = true;
        }
      });
      if (activeView == View.playing && !didHitAFly) {
        activeView = View.lost;
      }
    }
  }
}
