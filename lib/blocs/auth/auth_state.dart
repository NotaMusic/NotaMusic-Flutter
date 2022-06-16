import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const AuthState._();

  bool get isAuthorized => maybeMap(orElse: () => false, authorized: (_) => true);

  const factory AuthState.unauthorized() = _UnauthorizedState;

  const factory AuthState.authorized({
    required String token,
  }) = _AuthorizedState;

  const factory AuthState.errorWithToken({
    String? token,
  }) = _ErrorWithTokenState;

  const factory AuthState.wrongCredentials() = _WrongCredentialsState;

  //:TODO сделать отдельный стейт для текстовой ошибки
}
