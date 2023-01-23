import 'dart:math';

import 'package:flame/components.dart';

class Enemy extends SpriteComponent
    with HasGameRef {

  final double _speed = 250;

  Enemy({
    Sprite? sprite,
    Vector2? size,
    Vector2? position,
  }): super(sprite: sprite, size: size, position: position) {
    angle = pi ;
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Vector2(0, 1) makes sure that the enemy always moves
    // from top to bottom of the screen.
    // Update the position of this enemy using its speed and delta time.
    position += Vector2(0, 1) * _speed * dt;

    // If the enemy leaves the screen, destroy it.
    if (position.y >= gameRef.size.y) {
      removeFromParent();
    }
  }

  
}
