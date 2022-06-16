import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yandex_music_api_flutter/yandex_music_api_flutter.dart';


part 'main_page_state.freezed.dart';

@freezed
class MainPageState with _$MainPageState {
  const factory MainPageState({
    List<Station>? stations,
  }) = _MainPageState;
}