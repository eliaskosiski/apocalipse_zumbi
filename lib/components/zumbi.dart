import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:apocalipse_zumbi/components/zumbis.dart';
import 'package:apocalipse_zumbi/myGame.dart';

class Terra extends Zumbis {
  double get speed => game.tileSize * 5;

  Terra(MyGame game, double x, double y) : super(game) {
    zumbiRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
    zumbisSprite = List<Sprite>();
    zumbisSprite.add(Sprite('files/Zumbi.png'));
    deadSprite = Sprite('files/Sangue.png');
  }
}
