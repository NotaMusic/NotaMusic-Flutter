part of 'playlist_screen_cubit.dart';

@freezed
class PlaylistScreenState with _$PlaylistScreenState {
  const factory PlaylistScreenState.loadingPlaylist({
    Playlist? selectedPlaylist,
  }) = _LoadingPlaylist;

  const factory PlaylistScreenState.loadedPlaylist({
    required Playlist selectedPlaylist,
  }) = _LoadedPlaylist;

  const factory PlaylistScreenState.error({
    Playlist? selectedPlaylist,
    String? errorText,
  }) = _ErrorState;
}
