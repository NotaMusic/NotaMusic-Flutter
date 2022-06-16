import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nota_music/blocs/auth/auth_cubit.dart';
import 'package:nota_music/blocs/player_decorator/player_decorator_cubit.dart';
import 'package:nota_music/screens/main_page/motor_tab/motor_tab_cubit.dart';
import 'package:nota_music/screens/main_page/motor_tab/motor_tab_state.dart';
import 'package:nota_music/widgets/station_button.dart';

class MotorTab extends StatelessWidget {
  const MotorTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MotorTabCubit, MotorTabState>(
      bloc: MotorTabCubit(BlocProvider.of<AuthCubit>(context))..loadStations(),
      builder: (context, state) => state.map(
        loading: (state) => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (state) => Center(
          child: Text(state.error),
        ),
        loaded: (state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: GridView.builder(
              itemCount: state.stations.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 220,
                mainAxisExtent: 230,
                crossAxisSpacing: 32,
                mainAxisSpacing: 32,
              ),
              itemBuilder: (context, pos) => StationButton(
                station: state.stations[pos],
                onClick: () => BlocProvider.of<PlayerDecoratorCubit>(context).playStation(state.stations[pos]),
              ),
            ),
          );
        },
      ),
    );
  }
}
