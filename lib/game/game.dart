import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spacescape/game/player.dart';

// This class is responsible for initializing and running the game-loop
class SpacescapeGame extends FlameGame
    with HasGameRef,
        PanDetector {

  late Player player;
  Offset? _pointerStartPosition;
  Offset? _pointerCurrentPosition;
  final double _joystickRadius = 60;
  final double _deadZoneRadius = 10;

  // This method gets called by Flame before the game-loop begins.
  // Assets loading and adding component should be done here.
  @override
  Future<void> onLoad() async {
    // Loads the sprite sheet
    await images.load('simpleSpace_tilesheet@2.png');

    // Divides the sprite sheet into rows and columns for
    // easier access
    final spriteSheet = SpriteSheet.fromColumnsAndRows(
      image: images.fromCache('simpleSpace_tilesheet@2.png'),
      columns: 8,
      rows: 6,
    );

    // Chooses a sprite and places it on the screen
    player = Player(
      sprite: spriteSheet.getSpriteById(17),
      size: Vector2(64, 64),
      position: gameRef.size / 2,
    );

    // Makes sure that the sprite is centered
    // default anchor is Top Left
    player.anchor = Anchor.center;

    add(player);
  }

  // Adds joystick
  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Checks if user is touching the screen or not
    if (_pointerStartPosition != null) {
      // If user touches the screen, draw a circle on it
      canvas.drawCircle(
          _pointerStartPosition!,
          _joystickRadius,
          // withAlpha() is used to add a bit of transparency to the circle
          Paint()..color = Colors.grey.withAlpha(100),
      );
    }

    if (_pointerCurrentPosition != null) {
      var delta = _pointerCurrentPosition! - _pointerStartPosition!;

      // Checks if magnitude of delta is greater than 60, i.e. the smaller circle
      // does not go outside the bigger circle which has radius of 60
      if (delta.distance > 60) {
        delta = _pointerStartPosition! +
            (Vector2(delta.dx, delta.dy).normalized() * _joystickRadius).toOffset();
      } else {
        delta = _pointerCurrentPosition!;
      }

      canvas.drawCircle(
        delta,
        20,
        Paint()..color = Colors.white.withAlpha(100),
      );
    }
  }

  // Finds out the position at which the screen was touched at the
  // start and stores it in _pointerStartPosition
  @override
  void handlePanStart(DragStartDetails details) {
    _pointerStartPosition = details.globalPosition;
    _pointerCurrentPosition = details.globalPosition;
  }

  @override
  void handlePanUpdate(DragUpdateDetails details) {
    // Stores current position of pointer
    _pointerCurrentPosition = details.globalPosition;

    // delta is a vector from pointerStartPosition to pointerCurrentPosition
    var delta = _pointerCurrentPosition! - _pointerStartPosition!;

    // Creates a 'dead zone' for the joystick, which allows the user to stop
    // spaceship movement by keeping the joystick close to center
    if (delta.distance > _deadZoneRadius) {
      player.setMoveDirection(Vector2(delta.dx, delta.dy));
    } else {
      player.setMoveDirection(Vector2.zero());
    }
  }

  // User is not touching the screen, so set _pointerStartPosition as null
  @override
  void handlePanEnd(DragEndDetails details) {
    _pointerStartPosition = null;
    _pointerCurrentPosition = null;
    player.setMoveDirection(Vector2.zero());
  }

  // User is not touching the screen, so set _pointerStartPosition as null
  // and sprite's move direction is set to zero, i.e., sprite stops moving
  @override
  void onPanCancel() {
    _pointerStartPosition = null;
    _pointerCurrentPosition = null;
    player.setMoveDirection(Vector2.zero());
  }
}