import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nota_music/blocs/auth/auth_cubit.dart';
import 'package:yandex_music_api_flutter/playlist/playlist.dart';
import 'package:yandex_music_api_flutter/yandex_music_api_flutter.dart';

part 'playlists_tab_state.dart';
part 'playlists_tab_cubit.freezed.dart';


//TODO Для «мне нравится» есть отдельный метод или хак через константный ID = 1003

class PlaylistsTabCubit extends Cubit<PlaylistsTabState> {
  final AuthCubit authCubit;

  PlaylistsTabCubit({
    required this.authCubit,
  }) : super(const PlaylistsTabState.loading()) {
    authCubit.stream.listen(
      (event) => event.maybeWhen(
        orElse: () => null,
        authorized: (_, __) => reload(),
      ),
    );
  }

  Future<void> reload() async {
    emit(const PlaylistsTabState.loading());
    final id = authCubit.state.mapOrNull(
      authorized: (state) => state.account.uid,
    );
    if (id == null) {
      emit(
        const PlaylistsTabState.error(
          errorText: 'Ошибка при загрузке плейлистов',
        ),
      );
      return;
    }
    final playlists = await Client.instance.usersPlaylistsList(id.toString());
    if (playlists == null) {
      emit(
        const PlaylistsTabState.error(
          errorText: 'Ошибка при загрузке плейлистов',
        ),
      );
      return;
    }
    emit(PlaylistsTabState.loadingDone(playlists: playlists));
  }
}
