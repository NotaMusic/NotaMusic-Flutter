import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kplayer/kplayer.dart';
import 'package:nota_music/blocs/player_decorator/player_decorator_cubit.dart';
import 'package:nota_music/blocs/player_decorator/player_decorator_state.dart';

class PlayerControls extends StatelessWidget {
  const PlayerControls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<PlayerDecoratorCubit>(context);
    return BlocBuilder<PlayerDecoratorCubit, PlayerDecoratorState>(
      builder: (context, state) {
        return Material(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 5,
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder<Duration>(
                  stream: state.controller?.streams.position,
                  initialData: const Duration(seconds: 1),
                  builder: (context, snapshot) {
                    final max =
                        cubit.playerInst?.duration.inSeconds.toDouble() ?? 1;
                    var pos = snapshot.data?.inSeconds.toDouble() ?? 0;
                    if (pos < 0 || pos > max) {
                      pos = 0;
                    }
                    return Slider(
                      key: const ValueKey('playerNowPlayingPos'),
                      value: pos,
                      onChanged: (v) => cubit.setNewDuration(v),
                      min: 0,
                      max: max,
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              _buildInfo(state, cubit),
            ],
          ),
        ));
      },
    );
  }

  Widget _buildInfo(PlayerDecoratorState state, PlayerDecoratorCubit cubit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (!state.isPlayingRadio)
          IconButton(
              onPressed: () => cubit.prevTrack(),
              icon: const Icon(Iconsax.previous)),
        StreamBuilder<bool>(
          stream: state.controller?.streams.playing,
          initialData: false,
          builder: (context, snapshot) => IconButton(
            onPressed: () => cubit.playPauseTrack(),
            icon: Icon(
              // ignore: unrelated_type_equality_checks
              snapshot.data ?? false ? Iconsax.pause : Iconsax.play,
            ),
          ),
        ),
        IconButton(
            onPressed: () => cubit.nextTrack(), icon: const Icon(Iconsax.next)),
        const SizedBox(
          width: 18,
        ),
        if (state.currPlayTrack?.getCoverImage() != null)
          SizedBox(
            height: 32,
            child: Image.network(state.currPlayTrack!.getCoverImage()!),
          ),
        const SizedBox(
          width: 8,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(state.currPlayTrack?.artists?.map((e) => e.name).join(',') ??
                ''),
            const SizedBox(
              height: 4,
            ),
            Text(state.currPlayTrack?.title ?? '')
          ],
        ),
        const SizedBox(
          width: 18,
        ),
        IconButton(
            onPressed: () => cubit.likeTrack(),
            icon: const Icon(Iconsax.like_1)),
        IconButton(
            onPressed: () => cubit.dislikeTrack(),
            icon: const Icon(Iconsax.dislike)),
      ],
    );
  }
}
