import 'package:flame/components.dart';

class Bullet extends SpriteComponent {
  // Speed of the bullet.
  final double _speed = 450;

  Bullet({
    Sprite? sprite,
    Vector2? size,
    Vector2? position,
  }): super(sprite: sprite, size: size, position: position);

  @override
  void update(double dt) {
    super.update(dt);

    // Moves the bullet to a new position with _speed and direction.
    position += Vector2(0, -1) * _speed * dt;

    // If bullet crosses the upper boundary of screen
    // mark it to be removed it from the game world.
    if (position.y < 0) {
      removeFromParent();
    }
  }
}