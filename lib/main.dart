import 'package:desktop_webview_window/desktop_webview_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kplayer/kplayer.dart';
import 'package:nota_music/blocs/auth/auth_cubit.dart';
import 'package:nota_music/blocs/player_decorator/player_decorator_cubit.dart';
import 'package:nota_music/screens/main_page/main_page.dart';
import 'package:nota_music/widgets/player_controls.dart';
import 'package:yandex_music_api_flutter/playlist/playlist.dart';
import 'package:yandex_music_api_flutter/yandex_music_api_flutter.dart';

void main(List<String> args) {
  Player.boot();
  WidgetsFlutterBinding.ensureInitialized();

  // Add this your main method.
  // used to show a webview title bar.
  if (runWebViewTitleBarWidget(args)) {
    return;
  }
  Client(debugPrint: print);
  runApp(const MyApp());
}

void _print(Object obj) {
  print(obj);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NotaMusic',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
      builder: (context, widget) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: PlayerDecoratorCubit(),
            ),
            BlocProvider.value(
              value: AuthCubit(),
            ),
          ],
          child: Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: widget ?? const SizedBox.shrink(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  // ignore: prefer_const_constructors
                  child: PlayerControls(),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
