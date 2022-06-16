import 'package:kplayer/kplayer.dart';
import 'package:nota_music/player_decorator/player_decorator_state.dart';
import 'package:yandex_music_api_flutter/playlist/playlist.dart';
import 'package:yandex_music_api_flutter/rotor/station.dart';
import 'package:yandex_music_api_flutter/rotor/station_tracks_result.dart';
import 'package:yandex_music_api_flutter/track/track.dart';
import 'package:yandex_music_api_flutter/track/track_short.dart';
import 'package:bloc/bloc.dart';

class PlayerDecorator extends Cubit<PlayerDecoratorState> {
  PlayerDecorator() : super(PlayerDecoratorState());

  PlayerController? _playerInst;

  void playPlaylist(Playlist playlist) {
    emit(PlayerDecoratorState(
      currPlayStation: null,
      currPlaylist: playlist,
      currPlayTrack: playlist.tracks?.first.track,
    ));

    _playTrack(state.currPlayTrack);
    _playerInst?.callback = (PlayerEvent e) => _playerCallback(e, true);
  }

  Future<void> playStation(Station station) async {
    final currPlayStation = await station.getTracksRes();
    if (currPlayStation == null) return;

    emit(PlayerDecoratorState(
      currPlaylist: null,
      currPlayStation: currPlayStation,
      currPlayTrack: currPlayStation.sequence.first.track,
    ));

    _playTrack(state.currPlayTrack);
    _playerInst?.callback = (PlayerEvent e) => _playerCallback(e, false);
  }

  void _playerCallback(PlayerEvent event, bool isPlayPlaylist) {
    if(event == PlayerEvent.position){
      ///changedPosition
    }else {
      emit(state.copyWith(playerStatus: _playerInst?.status));
    }
  }

  Future<void> _playTrack(Track? track) async {
    if (track == null) return;
    final url = await track.getDownloadUrl();
    if (url == null) return;
    reInitPlayer(url);
    _playerInst?.play();
  }

  void reInitPlayer(String url) {
    _playerInst?.dispose();
    _playerInst = Player.network(url, once: true);
  }
}
