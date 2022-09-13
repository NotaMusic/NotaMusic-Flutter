import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nota_music/blocs/auth/auth_cubit.dart';
import 'package:nota_music/screens/main_page/detail_item_page/detail_item_page_arg.dart';
import 'package:yandex_music_api_flutter/album/album.dart';
import 'package:yandex_music_api_flutter/yandex_music_api_flutter.dart';

part 'detail_item_page_state.dart';
part 'detail_item_page_cubit.freezed.dart';

class DetailItemPageCubit extends Cubit<DetailItemPageState> {
  DetailItemPageCubit(this.arg, this.authCubit) : super(const DetailItemPageState.loading());

  final DetailItemPageArg arg;
  final AuthCubit authCubit;

  Future<void> loadContent() async {
    await arg.when(
      playlist: _loadPlaylist,
      album: _loadAlbum,
      artist: _loadArtist,
    );
  }

  Future<void> _loadPlaylist(String ownerId, String playlistKind) async {
    try {
      final loadedPlaylist = await (await Client.instance.usersPlaylistsList(
        ownerId,
        kind: [playlistKind],
      ))
          ?.first
          .getNormalWithTracks();

      if (loadedPlaylist == null) {
        emit(
          DetailItemPageState.error(
            content: DetailItemPageStateContent.error("Cant get tracks from playlist $playlistKind"),
          ),
        );
      } else {
        emit(
          DetailItemPageState.loaded(content: DetailItemPageStateContent.playlist(loadedPlaylist)),
        );
      }
    } catch (ex) {
      emit(
        DetailItemPageState.error(
          content: DetailItemPageStateContent.error(
              "Have error when loading playlist $playlistKind, ERROR: ${ex.toString()}"),
        ),
      );
    }
  }

  Future<void> _loadAlbum(String artistId, String albumId) async {
    try {
      final resp = await Client.instance.getAlbumWithTracks(albumId);
      if (resp.error == null) {
        emit(
          DetailItemPageState.loaded(
            content: DetailItemPageStateContent.album(resp),
          ),
        );
      } else {
        emit(
          DetailItemPageState.error(
            content: DetailItemPageStateContent.error(
              "Cant get album with id = $albumId",
            ),
          ),
        );
      }
    } catch (ex) {
      emit(
        DetailItemPageState.error(
          content: DetailItemPageStateContent.error(
            "Have error when loading album id = $albumId, ERROR: ${ex.toString()}",
          ),
        ),
      );
    }
  }

  Future<void> _loadArtist(String artistId) async {
    
  }
}
