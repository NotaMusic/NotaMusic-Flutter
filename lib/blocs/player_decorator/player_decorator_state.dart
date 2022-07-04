import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kplayer/kplayer.dart';
import 'package:yandex_music_api_flutter/playlist/playlist.dart';
import 'package:yandex_music_api_flutter/rotor/station_tracks_result.dart';
import 'package:yandex_music_api_flutter/track/track.dart';
import 'package:yandex_music_api_flutter/yandex_music_api_flutter.dart';

part 'player_decorator_state.freezed.dart';

@freezed
class PlayerDecoratorState with _$PlayerDecoratorState {
  const PlayerDecoratorState._();

  const factory PlayerDecoratorState({
    Playlist? currPlaylist,
    Station? currPlayStation,
    StationTracksResult? currPlayStationTracks,
    Track? currPlayTrack,
    PlayerStatus? playerStatus,
    PlayerController? controller,
  }) = _PlayerDecoratorState;

  bool get isPlayingRadio => currPlayStation != null;
}
