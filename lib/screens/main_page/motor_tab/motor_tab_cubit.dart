import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nota_music/blocs/auth/auth_cubit.dart';
import 'package:nota_music/screens/main_page/motor_tab/motor_tab_state.dart';
import 'package:yandex_music_api_flutter/yandex_music_api_flutter.dart';

class MotorTabCubit extends Cubit<MotorTabState> {
  MotorTabCubit(this.authCubit) : super(const MotorTabState.loading());

  final AuthCubit authCubit;

  Future<void> loadStations() async {
    emit(const MotorTabState.loading());
    try {
      final resp = await Client.instance.getRotorStationList();
      final stations = resp?.map((e) => e.station).where((element) => element != null).cast<Station>().toList();
      if (stations != null) {
        emit(MotorTabState.loaded(stations: stations));
      } else {
        emit(const MotorTabState.error(error: 'Яндекс не вернул список станций'));
      }
    } catch (ex, stack) {
      print(ex);
      print(stack);

      emit(MotorTabState.error(error: 'Ошибка: ${ex.toString()}'));
    }
  }
}
