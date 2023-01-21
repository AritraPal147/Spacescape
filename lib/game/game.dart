import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';

class SpacescapeGame extends FlameGame with HasGameRef{
  @override
  Future<void> onLoad() async{
    // Loads the sprite sheet image into cache
    await images.load('simpleSpace_tilesheet@2.png');

    // Divides the sprite sheet into rows and columns for
    // easier access
    final spriteSheet = SpriteSheet.fromColumnsAndRows(
        image: images.fromCache('simpleSpace_tilesheet@2.png'),
        columns: 8,
        rows: 6,
    );

    // Chooses a sprite and places it on the screen
    SpriteComponent player = SpriteComponent(
      sprite: spriteSheet.getSpriteById(17),
      size: Vector2(64, 64),
      position: gameRef.size / 2,
    );

    // Anchors sprite to center of screen instead of
    // top left by default
    player.anchor = Anchor.center;

    add(player);
  }
}