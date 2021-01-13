import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flame/util.dart';
import 'package:apocalipse_zumbi/myGame.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

void main() async {
  Util flameUtil = Util();
  WidgetsFlutterBinding.ensureInitialized();

  Flame.images.loadAll(<String>[
    'bg/Ponte.jpg',
    'files/Sangue.png',
    'files/Zumbi.png',
    'ui/Start',
  ]);

  Flame.audio.disableLog();
  Flame.audio.loadAll(<String>[
    '368735__leszek-szary__shoot-6.wav',
  ]);

  MyGame game = MyGame();
  runApp(game.widget);

  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  // ignore: deprecated_member_use
  flameUtil.addGestureRecognizer(tapper);
}
