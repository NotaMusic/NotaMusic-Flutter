// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:nota_music/blocs/auth/auth_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yandex_music_api_flutter/account/account.dart';
import 'package:yandex_music_api_flutter/yandex_music_api_flutter.dart';

class AuthCubit extends Cubit<AuthState> {
  static const tokenKey = 'TOKEN';

  late final SharedPreferences prefs;

  AuthCubit() : super(const AuthState.unauthorized()) {
    _init();
  }

  void setAuthToken(String token) async {
    await _setToken(token);
    emit(
      AuthState.authorized(
          token: token,
          account: (await Client.instance.getAccountRotorStatus()).account!),
    );
  }

  void logout() {
    emit(const AuthState.unauthorized());
    _setToken(null);
  }

  Future<void> _init() async {
    prefs = await SharedPreferences.getInstance();
    await _restoreState();
  }

  Future<void> _restoreState() async {
    final token = prefs.getString(tokenKey);
    if (token != null) {
      Client.instance.setTokenForClient(token);
      emit(
        AuthState.authorized(
            token: token,
            account: (await Client.instance.getAccountRotorStatus()).account!),
      );
    }
  }

  Future<void> _setToken(String? token) {
    if (token != null) {
      Client.instance.setTokenForClient(token);
      return prefs.setString(tokenKey, token);
    } else {
      return prefs.remove(tokenKey);
    }
  }
}
