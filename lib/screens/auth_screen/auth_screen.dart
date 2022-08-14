import 'package:auto_route/annotations.dart';
import 'package:desktop_webview_window/desktop_webview_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nota_music/blocs/auth/auth_cubit.dart';
import 'package:nota_music/blocs/auth/auth_state.dart';
import 'package:yandex_music_api_flutter/yandex_music_api_flutter.dart';


@AutoRoute()
class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key}) : super(key: key);

  final tokenCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              authorized: (token,_) {
                Client.instance.setTokenForClient(token);
                Navigator.of(context).pop();
              },
            );
          },
          builder: (context, state) => Text(state.toString()),
        ),
      ),
      body: Center(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 250,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const Text('Через браузер'),
                  TextButton(
                    child: const Text('Войти'),
                    onPressed: () => _tryAuth(context),
                  ),
                ]),
              ),
              const Text('or'),
              SizedBox(
                width: 250,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const Text('Токен'),
                  TextField(
                    controller: tokenCtrl,
                  ),
                  TextButton(
                    child: const Text('Ок'),
                    onPressed: () => BlocProvider.of<AuthCubit>(context).setAuthToken(tokenCtrl.text),
                  ),
                ]),
              ),
            ]),
      ),
    );
  }

  void _tryAuth(BuildContext context) async {
    final webview = await WebviewWindow.create();
    webview.addOnUrlRequestCallback((url) {
      if (url.contains('access_token')) {
        try {
          final token = url.split('#')[1].split('&')[0].replaceAll('access_token=', '');
          if (token.length > 3) {
            //validToken
            webview.close();
            BlocProvider.of<AuthCubit>(context).setAuthToken(token);
          }
        } catch (ex) {}
      }
      print('WebView callback : $url');
    });
    webview.launch("https://oauth.yandex.ru/authorize?response_type=token&client_id=23cabbbdc6cd418abb4b39c32c41195d");


    
  }
}
