

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yandex_music_api_flutter/yandex_music_api_flutter.dart';

part 'motor_tab_state.freezed.dart';

@freezed
class MotorTabState with _$MotorTabState {
  const factory MotorTabState.loading() = _Loading;
  const factory MotorTabState.loaded({required List<Station> stations}) = _Loaded;
  const factory MotorTabState.error({required String error}) = _Error;
}
