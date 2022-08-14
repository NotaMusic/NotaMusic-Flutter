import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yandex_music_api_flutter/account/account.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const AuthState._();

  bool get isAuthorized => maybeMap(orElse: () => false, authorized: (_) => true);

  Account? get account => map(
        unauthorized: (s) => null,
        authorized: (s) => s.account,
        errorWithToken: (s) => s.account,
        wrongCredentials: (s) => null,
      );

  const factory AuthState.unauthorized() = _UnauthorizedState;

  const factory AuthState.authorized({
    required String token,
    required Account account,
  }) = _AuthorizedState;

  const factory AuthState.errorWithToken({
    String? token,
    Account? account,
  }) = _ErrorWithTokenState;

  const factory AuthState.wrongCredentials() = _WrongCredentialsState;

  //:TODO сделать отдельный стейт для текстовой ошибки
}
