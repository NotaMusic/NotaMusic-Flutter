import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nota_music/blocs/auth/auth_cubit.dart';
import 'package:nota_music/blocs/player_decorator/player_decorator_cubit.dart';
import 'package:nota_music/screens/main_page/playlist_screen/playlist_screen_cubit.dart';
import 'package:nota_music/widgets/track_in_list.dart';

@AutoRoute()
class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({
    @PathParam('ownerId') required this.ownerId,
    @PathParam('playlistKind') required this.playlistKind,
    Key? key,
  }) : super(key: key);

  final String ownerId;
  final String playlistKind;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaylistScreenCubit, PlaylistScreenState>(
      bloc: PlaylistScreenCubit(BlocProvider.of<AuthCubit>(context), ownerId, playlistKind),
      builder: (context, state) {
        return state.when(
          loadingPlaylist: (selectedPlaylist) => const Center(
            child: SizedBox(
              width: 64,
              height: 64,
              child: CircularProgressIndicator(),
            ),
          ),
          loadedPlaylist: (playlist) => ListView.builder(
            itemCount: playlist.tracks!.length,
            itemBuilder: (context, pos) => TrackInList(
              track: playlist.tracks![pos].track!,
              onClick: () => BlocProvider.of<PlayerDecoratorCubit>(context).playTrackInPlaylist(
                playlist: playlist,
                track: playlist.tracks![pos].track!,
              ),
            ),
          ),
          error: (_, err) => Center(
            child: Text(err ?? 'Ошибка при загрузке плейлиста'),
          ),
        );
      },
    );
  }
}
