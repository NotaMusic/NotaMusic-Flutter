import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kplayer/kplayer.dart';
import 'package:yandex_music_api_flutter/playlist/playlist.dart';
import 'package:yandex_music_api_flutter/rotor/station_tracks_result.dart';
import 'package:yandex_music_api_flutter/track/track.dart';

part 'player_decorator_state.freezed.dart';

@freezed
class PlayerDecoratorState with _$PlayerDecoratorState {
  const factory PlayerDecoratorState({
    Playlist? currPlaylist,
    StationTracksResult? currPlayStation,
    Track? currPlayTrack,
    PlayerStatus? playerStatus,
  }) = _PlayerDecoratorState;
}
