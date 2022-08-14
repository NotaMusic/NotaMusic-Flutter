import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:nota_music/screens/auth_screen/auth_screen.dart';
import 'package:nota_music/screens/main_page/main_page.dart';
import 'package:nota_music/screens/main_page/motor_tab/motor_tab.dart';
import 'package:nota_music/screens/main_page/playlists_tab/playlists_tab.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route,Tab,Screen',
  routes: <AutoRoute>[
    AutoRoute(
      page: MainPage,
      initial: true,
      name: 'MainPageController',
      children: [
        AutoRoute(page: MotorTab, path: ''),
        AutoRoute(page: PlaylistsTab),
      ],
    ),
    AutoRoute(page: AuthScreen),
  ],
)
// extend the generated private router
class AppRouter extends _$AppRouter {}
