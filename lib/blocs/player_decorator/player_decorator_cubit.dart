import 'dart:async';

import 'package:kplayer/kplayer.dart';
import 'package:nota_music/blocs/player_decorator/player_decorator_state.dart';
import 'package:yandex_music_api_flutter/playlist/playlist.dart';
import 'package:yandex_music_api_flutter/rotor/station.dart';
import 'package:yandex_music_api_flutter/rotor/station_feedback.dart';
import 'package:yandex_music_api_flutter/track/track.dart';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yandex_music_api_flutter/yandex_music_api_flutter.dart';

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
    final currPlayStationTracks = await station.getTracksRes();
    if (currPlayStationTracks == null) return;

    emit(PlayerDecoratorState(
      currPlaylist: null,
      currPlayStation: station,
      currPlayStationTracks: currPlayStationTracks,
      currPlayTrack: currPlayStationTracks.sequence.first.track,
    ));

    Client.instance.rotorStationFeedback(
      station: station,
      feedback: StationFeedback.radioStarted,
      batchId: currPlayStationTracks.batchId,
    );
    _playTrack(state.currPlayTrack);
    Client.instance.rotorStationFeedback(
      station: station,
      feedback: StationFeedback.trackStarted,
      trackId: state.currPlayTrack!.id.toString(),
    );
    playerInst?.callback = (PlayerEvent e) => _playerCallback(e, false);
  }

  void setNewDuration(double seconds) {
    playerInst?.position = Duration(seconds: seconds.round());
  }

  void prevTrack() {
    final currPos = state.currPlaylist!.tracks!.indexWhere(
      (element) => element.track?.id == state.currPlayTrack!.id,
    );
    if (currPos == 0) {
      return;
    }

    _playTrack(state.currPlaylist!.tracks![currPos - 1].track);
  }

  void nextTrack() => _onTrackEnded(isSkip: true);

  void likeTrack() {}

  void dislikeTrack() {}

  void playPauseTrack() {
    if (playerInst != null) {
      playerInst!.playing ? playerInst!.pause() : playerInst!.play();
    }
  }

  void playTrackInPlaylist({required Playlist playlist, required Track track}) {
    emit(PlayerDecoratorState(
      currPlayStation: null,
      currPlaylist: playlist,
      currPlayTrack: track,
    ));
    _playTrack(track);
    playerInst?.callback = (PlayerEvent e) => _playerCallback(e, true);
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
    emit(state.copyWith(controller: playerInst, currPlayTrack: track));
  }

  void reInitPlayer(String url) {
    playerInst?.stop();
    playerInst?.dispose();
    playerInst = Player.network(url, once: true)..init();
  }

  void _onTrackEnded({bool isSkip = false}) {
    if (state.isPlayingRadio) {
      if (isSkip) {
        Client.instance.rotorStationFeedback(
          station: state.currPlayStation!,
          feedback: StationFeedback.skip,
          trackId: state.currPlayTrack!.id.toString(),
        );
      } else {
        Client.instance.rotorStationFeedback(
          station: state.currPlayStation!,
          feedback: StationFeedback.trackFinished,
          trackId: state.currPlayTrack!.id.toString(),
        );
      }

      final currPos = state.currPlayStationTracks!.sequence.indexWhere(
        (element) => element.track!.id == state.currPlayTrack!.id,
      );
      if (state.currPlayStationTracks!.sequence.length == currPos + 1) {
        _getNewRotorSequence().then(
          (_) => _playTrack(state.currPlayStationTracks!.sequence.first.track),
        );
      } else {
        _playTrack(state.currPlayStationTracks!.sequence[currPos + 1].track);
      }
    } else {
      final currPos = state.currPlaylist!.tracks!.indexWhere(
        (element) => element.track?.id == state.currPlayTrack!.id,
      );

      if (currPos + 1 >= state.currPlaylist!.tracks!.length) {
        //last track
        return;
      }
      _playTrack(state.currPlaylist!.tracks![currPos + 1].track);
    }
  }

  Future<void> _getNewRotorSequence() async {
    final currPlayStationTracks = await state.currPlayStation!.getTracksRes(queue: state.currPlayTrack!.id.toString());
    if (currPlayStationTracks == null) return;
    Client.instance.rotorStationFeedback(
      station: state.currPlayStation!,
      feedback: StationFeedback.radioStarted,
      trackId: state.currPlayTrack!.id.toString(),
      batchId: currPlayStationTracks.batchId,
    );

    emit(PlayerDecoratorState(
      currPlaylist: null,
      currPlayStation: state.currPlayStation!,
      currPlayStationTracks: currPlayStationTracks,
    ));
  }
}
