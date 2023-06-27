import 'package:flame/game.dart';
import 'components/player.dart';
import '../helpers/direction.dart';

final Player _player = Player();

class RayWorldGame extends FlameGame{
  void onJoypadDirectionChanged(Direction direction){
    _player.direction = direction;
  }

  @override
  Future<void> onLoad() async {
    // empty
    add(_player);
  }
}