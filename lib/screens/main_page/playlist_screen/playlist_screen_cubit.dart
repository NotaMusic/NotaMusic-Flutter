import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nota_music/blocs/auth/auth_cubit.dart';
import 'package:yandex_music_api_flutter/yandex_music_api_flutter.dart';

part 'playlist_screen_state.dart';
part 'playlist_screen_cubit.freezed.dart';

class PlaylistScreenCubit extends Cubit<PlaylistScreenState> {
  final String playlistKind;
  final String ownerId;
  final AuthCubit authCubit;

  PlaylistScreenCubit(
    this.authCubit,
    this.ownerId,
    this.playlistKind,
  ) : super(const PlaylistScreenState.loadingPlaylist()) {
    loadPlaylist();
  }

  Future<void> loadPlaylist() async {
    try {
      final loadedPlaylist = await (await Client.instance.usersPlaylistsList(
        ownerId,
        kind: [playlistKind],
      ))
          ?.first
          .getNormalWithTracks();

      if (loadedPlaylist == null) {
        emit(
          PlaylistScreenState.error(
            selectedPlaylist: loadedPlaylist,
            errorText: "Cant get tracks from playlist $playlistKind",
          ),
        );
      } else {
        emit(
          PlaylistScreenState.loadedPlaylist(
            selectedPlaylist: loadedPlaylist,
          ),
        );
      }
    } catch (ex) {
      emit(
        PlaylistScreenState.error(
          selectedPlaylist: null,
          errorText: "Have error when loading playlist $playlistKind, ERROR: ${ex.toString()}",
        ),
      );
    }
  }
}
