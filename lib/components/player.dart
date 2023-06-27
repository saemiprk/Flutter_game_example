import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import '../helpers/direction.dart';

class Player extends SpriteAnimationComponent with HasGameRef{
  Direction direction = Direction.none;

  final double _animationSpeed = 0.15;
  late final SpriteAnimation _runDownAnimation;
  late final SpriteAnimation _runLeftAnimation;
  late final SpriteAnimation _runUpAnimation;
  late final SpriteAnimation _runRightAnimation;
  late final SpriteAnimation _standingAnimation;

  Player()
  : super(
    size: Vector2.all(50.0),
  );

  @override
  Future<void> onLoad() async {
    // super.onLoad();
    // // TODO 1
    // sprite = await gameRef.loadSprite('player.png');
    // position = gameRef.size / 2;
    await _loadAnimations().then((_) => {animation = _standingAnimation});
  }
  Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: await gameRef.images.load('player_spritesheet.png'),
      srcSize: Vector2(29.0, 32.0)
    );
    // ToDO down
    _runDownAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to:4);
    _runLeftAnimation =
        spriteSheet.createAnimation(row: 1, stepTime: _animationSpeed, to:4);
    _runUpAnimation =
        spriteSheet.createAnimation(row: 2, stepTime: _animationSpeed, to:4);
    _runRightAnimation =
        spriteSheet.createAnimation(row: 3, stepTime: _animationSpeed, to:4);
    _standingAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to:1);

  }

  final double _playerSpeed = 200.0;
  @override
  void update(double delta){
    super.update(delta);
    movePlayer(delta);
  }
  void moveDown(double delta){
    position.add(Vector2(0, delta * _playerSpeed));
  }
  void moveUp(double delta){
    position.add(Vector2(0, -delta * _playerSpeed));
  }
  void moveLeft(double delta){
    position.add(-Vector2(delta * _playerSpeed, 0));
  }
  void moveRight(double delta){
    position.add(Vector2(delta * _playerSpeed, 0));
  }
  void movePlayer(double delta){
    // TODO
    switch (direction) {
      case Direction.up:
        animation = _runUpAnimation;
        moveUp(delta);
        break;
      case Direction.down:
        animation = _runDownAnimation;
        moveDown(delta);
        break;
      case Direction.left:
        animation = _runLeftAnimation;
        moveLeft(delta);
        break;
      case Direction.right:
        animation = _runRightAnimation;
        moveRight(delta);
        break;
      case Direction.none:
        animation = _standingAnimation;
        break;
    }
  }
}