import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nota_music/blocs/auth/auth_cubit.dart';
import 'package:nota_music/blocs/auth/auth_state.dart';
import 'package:nota_music/screens/auth_screen/auth_screen.dart';
import 'package:nota_music/screens/main_page/motor_tab/motor_tab.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) => state.isAuthorized
                  ? IconButton(
                      onPressed: () => _logout(context),
                      icon: const Icon(Iconsax.logout))
                  : IconButton(
                      onPressed: () => _goToAuth(context),
                      icon: const Icon(Iconsax.login)),
            )
          ],
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Iconsax.home), child: Text('Home')),
              Tab(icon: Icon(Iconsax.radio), child: Text('Radio')),
              Tab(icon: Icon(Iconsax.music_playlist), child: Text('Playlists')),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(
              child: Text('Home under dev'),
            ),
            MotorTab(),
            Center(
              child: Text('Playlists under dev'),
            ),
          ],
        ),
      ),
    );
  }

  void _goToAuth(BuildContext context) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (_) => AuthScreen()));

  void _logout(BuildContext context) =>
      BlocProvider.of<AuthCubit>(context).logout();
}
