// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    MainPageController.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const MainPage());
    },
    AuthScreenRoute.name: (routeData) {
      final args = routeData.argsAs<AuthScreenRouteArgs>(
          orElse: () => const AuthScreenRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData, child: AuthScreen(key: args.key));
    },
    MotorTabRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const MotorTab());
    },
    PlaylistsTabRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const PlaylistsTab());
    },
    PlaylistScreenRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PlaylistScreenRouteArgs>(
          orElse: () => PlaylistScreenRouteArgs(
              ownerId: pathParams.getString('ownerId'),
              playlistKind: pathParams.getString('playlistKind')));
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: PlaylistScreen(
              ownerId: args.ownerId,
              playlistKind: args.playlistKind,
              key: args.key));
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(MainPageController.name, path: '/', children: [
          RouteConfig(MotorTabRoute.name,
              path: '', parent: MainPageController.name),
          RouteConfig(PlaylistsTabRoute.name,
              path: 'playlists-tab', parent: MainPageController.name),
          RouteConfig(PlaylistScreenRoute.name,
              path: 'playlist/:ownerId/:playlistKind',
              parent: MainPageController.name)
        ]),
        RouteConfig(AuthScreenRoute.name, path: '/auth-screen')
      ];
}

/// generated route for
/// [MainPage]
class MainPageController extends PageRouteInfo<void> {
  const MainPageController({List<PageRouteInfo>? children})
      : super(MainPageController.name, path: '/', initialChildren: children);

  static const String name = 'MainPageController';
}

/// generated route for
/// [AuthScreen]
class AuthScreenRoute extends PageRouteInfo<AuthScreenRouteArgs> {
  AuthScreenRoute({Key? key})
      : super(AuthScreenRoute.name,
            path: '/auth-screen', args: AuthScreenRouteArgs(key: key));

  static const String name = 'AuthScreenRoute';
}

class AuthScreenRouteArgs {
  const AuthScreenRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'AuthScreenRouteArgs{key: $key}';
  }
}

/// generated route for
/// [MotorTab]
class MotorTabRoute extends PageRouteInfo<void> {
  const MotorTabRoute() : super(MotorTabRoute.name, path: '');

  static const String name = 'MotorTabRoute';
}

/// generated route for
/// [PlaylistsTab]
class PlaylistsTabRoute extends PageRouteInfo<void> {
  const PlaylistsTabRoute()
      : super(PlaylistsTabRoute.name, path: 'playlists-tab');

  static const String name = 'PlaylistsTabRoute';
}

/// generated route for
/// [PlaylistScreen]
class PlaylistScreenRoute extends PageRouteInfo<PlaylistScreenRouteArgs> {
  PlaylistScreenRoute(
      {required String ownerId, required String playlistKind, Key? key})
      : super(PlaylistScreenRoute.name,
            path: 'playlist/:ownerId/:playlistKind',
            args: PlaylistScreenRouteArgs(
                ownerId: ownerId, playlistKind: playlistKind, key: key),
            rawPathParams: {'ownerId': ownerId, 'playlistKind': playlistKind});

  static const String name = 'PlaylistScreenRoute';
}

class PlaylistScreenRouteArgs {
  const PlaylistScreenRouteArgs(
      {required this.ownerId, required this.playlistKind, this.key});

  final String ownerId;

  final String playlistKind;

  final Key? key;

  @override
  String toString() {
    return 'PlaylistScreenRouteArgs{ownerId: $ownerId, playlistKind: $playlistKind, key: $key}';
  }
}
