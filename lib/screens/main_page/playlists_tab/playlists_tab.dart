import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nota_music/blocs/auth/auth_cubit.dart';
import 'package:nota_music/blocs/player_decorator/player_decorator_cubit.dart';
import 'package:nota_music/screens/main_page/playlists_tab/playlists_tab_cubit.dart';
import 'package:nota_music/widgets/playlist_button.dart';
import 'package:nota_music/widgets/track_in_list.dart';

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
                onClick: () => bloc.selectPlaylist(playlists[pos]),
              ),
            ),
            loadingSelectedPlaylist: (playlists, selectedPlaylist) => Stack(
              children: [
                GridView.builder(
                  itemCount: playlists.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 220,
                    mainAxisExtent: 230,
                    crossAxisSpacing: 32,
                    mainAxisSpacing: 32,
                  ),
                  itemBuilder: (context, pos) => PlaylistButton(
                    playlist: playlists[pos],
                    onClick: () => bloc.selectPlaylist(playlists[pos]),
                  ),
                ),
                LayoutBuilder(
                  builder: (context, constraints) => Container(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    alignment: Alignment.center,
                    color: Colors.black45,
                    child: const SizedBox(
                      width: 64,
                      height: 63,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ],
            ),
            playlistSelected: (playlists, selectedPlaylist) => Stack(children: [
              GridView.builder(
                itemCount: playlists.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 220,
                  mainAxisExtent: 230,
                  crossAxisSpacing: 32,
                  mainAxisSpacing: 32,
                ),
                itemBuilder: (context, pos) => PlaylistButton(
                  playlist: playlists[pos],
                  onClick: () => bloc.selectPlaylist(playlists[pos]),
                ),
              ),
              LayoutBuilder(
                builder: (context, constraints) => GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: ()=> bloc.closePlaylist(),
                  child: Container(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    alignment: Alignment.center,
                    color: Colors.black45,
                  ),
                ),
              ),

              Container(
                color: Colors.white,
                
                child: ListView.builder(
                    itemCount: selectedPlaylist.tracks!.length,
                    itemBuilder: (context, pos) => TrackInList(
                      track: selectedPlaylist.tracks![pos].track!,
                      onClick: () => BlocProvider.of<PlayerDecoratorCubit>(context).playTrackInPlaylist(
                        playlist: selectedPlaylist,
                        track: selectedPlaylist.tracks![pos].track!,
                      ),
                    ),
                  ),
              )
              // Column(children: [
              //   Align(
              //     alignment: Alignment.topRight,
              //     child: IconButton(
              //       icon: const Icon(Icons.close),
              //       onPressed: () => bloc.closePlaylist(),
              //     ),
              //   ),
              //   Expanded(
              //     child: ListView.builder(
              //       // shrinkWrap: true,
              //       itemCount: selectedPlaylist.tracks!.length,
              //       itemBuilder: (context, pos) => TrackInList(
              //         track: selectedPlaylist.tracks![pos].track!,
              //         onClick: () => BlocProvider.of<PlayerDecoratorCubit>(context).playTrackInPlaylist(
              //           playlist: selectedPlaylist,
              //           track: selectedPlaylist.tracks![pos].track!,
              //         ),
              //       ),
              //     ),
              //   ),
              // ])
            ]),
            error: (_, __, text) => Center(
              child: Text(text ?? 'Ошибка при загрузке плейлистов'),
            ),
          ),
        );
      },
    );
  }
}
