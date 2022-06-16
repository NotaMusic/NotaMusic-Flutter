import 'dart:async';

import 'package:kplayer/kplayer.dart';
import 'package:nota_music/blocs/player_decorator/player_decorator_state.dart';
import 'package:yandex_music_api_flutter/playlist/playlist.dart';
import 'package:yandex_music_api_flutter/rotor/station.dart';
import 'package:yandex_music_api_flutter/track/track.dart';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

class PlayerDecoratorCubit extends Cubit<PlayerDecoratorState> {
  PlayerDecoratorCubit() : super(const PlayerDecoratorState());

  PlayerController? playerInst;

  void playPlaylist(Playlist playlist) {
    emit(PlayerDecoratorState(
      currPlayStation: null,
      currPlaylist: playlist,
      currPlayTrack: playlist.tracks?.first.track,
    ));

    _playTrack(state.currPlayTrack);
    playerInst?.callback = (PlayerEvent e) => _playerCallback(e, true);
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
    playerInst?.callback = (PlayerEvent e) => _playerCallback(e, false);
  }

  void setNewDuration(double seconds) {
    playerInst?.position = Duration(seconds: seconds.round());
  }

  void prevTrack() {
    final currPos = state.currPlaylist!.tracks!.indexWhere(
      (element) => element.track.id == state.currPlayTrack!.id,
    );
    if (currPos == 0) {
      return;
    }

    _playTrack(state.currPlaylist!.tracks![currPos - 1].track);
  }

  void nextTrack() => _onTrackEnded();

  void likeTrack() {}

  void dislikeTrack() {}

  void playPauseTrack() {
    if (playerInst != null) {
      playerInst!.playing ? playerInst!.pause() : playerInst!.play();
    }
  }

  void _playerCallback(PlayerEvent event, bool isPlayPlaylist) {
    if (event == PlayerEvent.end) {
      //todo on track ended
      _onTrackEnded();
    } else {
      emit(state.copyWith(playerStatus: playerInst?.status));
    }
  }

  Future<void> _playTrack(Track? track) async {
    print('[Player_decorator_cubit] Play track: ${track.toString()}');
    if (track == null) return;
    final url = await track.getDownloadUrl();
    if (url == null) return;
    reInitPlayer(url);
    playerInst?.play();
    emit(state.copyWith(controller: playerInst));
  }

  void reInitPlayer(String url) {
    playerInst?.stop();
    playerInst?.dispose();
    playerInst = Player.network(url, once: true)..init();
  }

  void _onTrackEnded() {
    if (state.isPlayingRadio) {
    } else {
      final currPos = state.currPlaylist!.tracks!.indexWhere(
        (element) => element.track.id == state.currPlayTrack!.id,
      );

      if (currPos + 1 >= state.currPlaylist!.tracks!.length) {
        //last track
        return;
      }
      _playTrack(state.currPlaylist!.tracks![currPos + 1].track);
    }
  }
}
