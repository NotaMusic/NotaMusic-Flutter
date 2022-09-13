part of 'detail_item_page_cubit.dart';

@freezed
class DetailItemPageState with _$DetailItemPageState {
  const factory DetailItemPageState.loading({
    DetailItemPageStateContent? content,
  }) = _Loading;

  const factory DetailItemPageState.loaded({
    required DetailItemPageStateContent content,
  }) = _Loaded;
  
  const factory DetailItemPageState.error({
    DetailItemPageStateContent? content,
  }) = _Error;
}

@freezed
class DetailItemPageStateContent with _$DetailItemPageStateContent {
  factory DetailItemPageStateContent.playlist(Playlist playlist) = _Playlist;
  factory DetailItemPageStateContent.album(Album album) = _Album;
  factory DetailItemPageStateContent.artist(Album artist) = _Artist;
  factory DetailItemPageStateContent.error(String errorStr) = _ErrorContent;
}
