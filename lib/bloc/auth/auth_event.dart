part of 'auth_bloc.dart';

sealed class AuthEvent {}
// State = action
// 1. login => proses login
// 2. logout => proses logout

class AuthEventLogin extends AuthEvent {
  AuthEventLogin(
    this.email,
    this.password,
  );
  final String email;
  final String password;
}

class AuthEventLogout extends AuthEvent {}
