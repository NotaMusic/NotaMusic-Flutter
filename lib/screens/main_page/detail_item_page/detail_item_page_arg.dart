import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail_item_page_arg.freezed.dart';

@freezed
abstract class DetailItemPageArg with _$DetailItemPageArg {
  factory DetailItemPageArg.playlist({
    required String ownerId,
    required String playlistKind,
  }) = _DetailItemPagePlaylist;
  factory DetailItemPageArg.album({
    required String artistId,
    required String albumId,
  }) = _DetailItemPageAlbum;
  factory DetailItemPageArg.artist({
    required String artistId,
  }) = _DetailItemPageArtist;
}
