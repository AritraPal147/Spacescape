import 'package:flame/components.dart';

// This component class represents the player character in game
class Player extends SpriteComponent
    with HasGameRef {
  // Controls in which direction the player should move.
  // Magnitude of this vector doesn't matter, it is just used for getting direction.
  Vector2 _moveDirection = Vector2.zero();

  // Move speed of this player.
  final double _speed = 300;

  // Takes sprite, size and position and forwards it to the base class,
  // i.e., Sprite Component, which allows us to create required sprite.
  Player({
    Sprite? sprite,
    Vector2? size,
    Vector2? position,
  }): super(sprite: sprite, size: size, position: position);

  // This method is called by game class for every frame.
  @override
  void update(double dt) {
    // dt is the input delta time -> time elapsed since last update call
    // For devices with higher frame rates, delta time will be smaller and
    // for devices with lower frame rates it will be larger.
    super.update(dt);

    // Increment the current position of player by speed * delta time along moveDirection
    // Multiplying speed with delta time ensures that player speed remains the same
    // irrespective of device FPS.
    position += _moveDirection.normalized() * _speed * dt;
    // Vector2.normalized() returns a unit vector along the given vector

    // Clamp position of player such that the player sprite does not go outside the screen size.
    // size is the size of player sprite, which is added here so that half the sprite
    // does not hang outside the screen.
    position.clamp(
      Vector2.zero() + size / 2,
      gameRef.size - size / 2,
    );
  }

  // Function for updating the move direction
  void setMoveDirection(Vector2 newMoveDirection){
    _moveDirection = newMoveDirection;
  }
}