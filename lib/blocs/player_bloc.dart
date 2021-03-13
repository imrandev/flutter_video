import 'package:flutter_video/blocs/enums/player_state.dart';
import 'package:flutter_video/blocs/provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class PlayerBloc extends BlocBase {

  final _playerStateBehavior = BehaviorSubject<PlayerState>();

  Stream<PlayerState> get playerStateStream => _playerStateBehavior.stream;

  Function(PlayerState) get _playerStateSink => _playerStateBehavior.sink.add;

  onPlayerStateChange(PlayerState playerState) {
    _playerStateSink(playerState);
  }

  @override
  void dispose() {
    _playerStateBehavior.close();
  }
}