import 'package:flame/components.dart';

class Player extends SpriteComponent{
  Vector2 _moveDirection = Vector2.zero();

  final double _speed = 300;

  // Takes sprite, size and position and forwards it to the base class,
  // i.e., Sprite Component, which allows us to create required sprite
  Player({
    Sprite? sprite,
    Vector2? size,
    Vector2? position,
  }): super(sprite: sprite, size: size, position: position);

  @override
  void update(double dt) {
    // dt is the input delta time -> time elapsed since last update call
    super.update(dt);

    // Vector2.normalized() returns a unit vector along the given vector
    position += _moveDirection.normalized() * _speed * dt;
  }

  // Function for updating the move direction
  void setMoveDirection(Vector2 newMoveDirection){
    _moveDirection = newMoveDirection;
  }
}