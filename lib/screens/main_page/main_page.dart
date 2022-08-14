import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nota_music/blocs/auth/auth_cubit.dart';
import 'package:nota_music/blocs/auth/auth_state.dart';
import 'package:nota_music/router/app_router.dart';
import 'package:nota_music/screens/auth_screen/auth_screen.dart';
import 'package:nota_music/screens/main_page/motor_tab/motor_tab.dart';
import 'package:nota_music/screens/main_page/playlists_tab/playlists_tab.dart';
import 'package:auto_route/annotations.dart';

@AutoRoute()
class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:  AutoLeadingButton(),
        actions: [
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) => state.isAuthorized
                ? IconButton(onPressed: () => _logout(context), icon: const Icon(Iconsax.logout))
                : IconButton(onPressed: () => _goToAuth(context), icon: const Icon(Iconsax.login)),
          )
        ],
      ),
      body: Row(
        children: [
          Column(
            children: [
              Tab(icon: Icon(Iconsax.home), child: Text('Home')),
              GestureDetector(
                onTap: () => context.router.push(const MotorTabRoute()),
                child: const Tab(
                  icon: Icon(Iconsax.radio),
                  child: Text('Radio'),
                ),
              ),
              GestureDetector(
                onTap: () => context.router.push(const PlaylistsTabRoute()),
                child: const Tab(
                  icon: Icon(Iconsax.music_playlist),
                  child: Text('Playlists'),
                ),
              ),
            ],
          ),
          const Expanded(
            // nested routes will be rendered here
            child: AutoRouter(),
          )
        ],
      ),
    );
  }

  void _goToAuth(BuildContext context) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => AuthScreen()));

  void _logout(BuildContext context) => BlocProvider.of<AuthCubit>(context).logout();
}
