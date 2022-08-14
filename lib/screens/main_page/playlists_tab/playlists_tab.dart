import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nota_music/blocs/auth/auth_cubit.dart';
import 'package:nota_music/blocs/player_decorator/player_decorator_cubit.dart';
import 'package:nota_music/router/app_router.dart';
import 'package:nota_music/screens/main_page/playlists_tab/playlists_tab_cubit.dart';
import 'package:nota_music/widgets/playlist_button.dart';
import 'package:nota_music/widgets/track_in_list.dart';

@AutoRoute()
class PlaylistsTab extends StatelessWidget {
  const PlaylistsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = PlaylistsTabCubit(authCubit: BlocProvider.of<AuthCubit>(context))..reload();
    return BlocBuilder<PlaylistsTabCubit, PlaylistsTabState>(
      bloc: bloc,
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
                onClick: () => context.router.push(
                  PlaylistScreenRoute(
                    ownerId: playlists[pos].uid.toString(),
                    playlistKind: playlists[pos].kind.toString(),
                  ),
                ),
              ),
            ),
            error: (_, __, text) => Center(
              child: Text(text ?? 'Ошибка при загрузке плейлистов'),
            ),
          ),
        );
      },
    );
  }
}
