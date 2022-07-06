part of 'playlists_tab_cubit.dart';

@freezed
class PlaylistsTabState with _$PlaylistsTabState {
  const factory PlaylistsTabState.loading() = _LoadingState;
  
  const factory PlaylistsTabState.loadingDone({
    required List<Playlist> playlists,
  }) = _LoadingDoneState;

  const factory PlaylistsTabState.playlistSelected({
    required List<Playlist> playlists,
    required Playlist selectedPlaylist,
  }) = _PlaylistSelectedState;


  const factory PlaylistsTabState.error({
    List<Playlist>? playlists,
    Playlist? selectedPlaylist,
    String? errorText
  }) = _ErrorState;
}
