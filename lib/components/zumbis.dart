import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:apocalipse_zumbi/myGame.dart';
import 'package:flame/flame.dart';

class Zumbis {
  Rect zumbiRect;
  final MyGame game;
  List<Sprite> zumbisSprite;
  Sprite deadSprite;
  double zumbisSpriteIndex = 0;
  bool isDead = false;
  bool isOffScreen = false;
  Offset targetLocation;

  double get speed => game.tileSize * 3;

  Zumbis(this.game) {
    setTargetLocation();
  }

  void setTargetLocation() {
    double x = game.rnd.nextDouble() *
        (game.screenSize.width - (game.tileSize * 2.025));
    double y = game.rnd.nextDouble() *
        (game.screenSize.height - (game.tileSize * 2.025));
    targetLocation = Offset(x, y);
  }

  void render(Canvas c) {
    if (isDead) {
      deadSprite.renderRect(c, zumbiRect.inflate(2));
    } else {
      zumbisSprite[zumbisSpriteIndex.toInt()]
          .renderRect(c, zumbiRect.inflate(2));
    }
  }

  void update(double t) {
    if (isDead) {
      zumbiRect = zumbiRect.translate(0, game.tileSize * 12 * t);
      if (zumbiRect.top > game.screenSize.height) {
        isOffScreen = true;
      }
    }
    double stepDistance = speed * t;
    Offset toTarget = targetLocation - Offset(zumbiRect.left, zumbiRect.top);
    if (stepDistance < toTarget.distance) {
      Offset stepToTarget =
          Offset.fromDirection(toTarget.direction, stepDistance);
      zumbiRect = zumbiRect.shift(stepToTarget);
    } else {
      zumbiRect = zumbiRect.shift(toTarget);
      setTargetLocation();
    }
  }

  void onTapDown() {
    isDead = true;
    Flame.audio.play('368735__leszek-szary__shoot-6.wav');
  }
}
