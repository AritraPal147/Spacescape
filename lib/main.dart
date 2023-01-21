import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:spacescape/game/game.dart';

void main() {
  /*
  If Flutter needs to call native code before calling runApp
  WidgetsFlutterBinding.ensureInitialized();
  makes sure that you have an instance of the WidgetsBinding,
  which is required to use platform channels to call the native code.
  You only need to call this method if you need the binding to be
  initialized before calling runApp.
  */

  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  runApp(
    GameWidget(
      game: SpacescapeGame(),
    ),
  );
}


