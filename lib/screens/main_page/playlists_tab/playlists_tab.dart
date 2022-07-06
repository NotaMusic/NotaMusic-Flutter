import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nota_music/blocs/auth/auth_cubit.dart';
import 'package:nota_music/screens/main_page/playlists_tab/playlists_tab_cubit.dart';
import 'package:nota_music/widgets/playlist_button.dart';

class PlaylistsTab extends StatelessWidget {
  const PlaylistsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaylistsTabCubit, PlaylistsTabState>(
      bloc: PlaylistsTabCubit(authCubit: BlocProvider.of<AuthCubit>(context))..reload(),
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: state.when(
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loadingDone: (playlists) => GridView.builder(
              itemCount: playlists.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 220,
                mainAxisExtent: 230,
                crossAxisSpacing: 32,
                mainAxisSpacing: 32,
              ),
              itemBuilder: (context, pos) => PlaylistButton(
                playlist: playlists[pos],
                onClick: () {},
              ),
            ),
            playlistSelected: (playlists, selectedPlaylist) => Container(),
            error: (_, __, text) => Center(
              child: Text(text ?? 'Ошибка при загрузке плейлистов'),
            ),
          ),
        );
      },
    );
  }
}
