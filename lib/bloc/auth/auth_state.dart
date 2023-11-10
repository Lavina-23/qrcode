part of 'auth_bloc.dart';

// State = kondisi
// 1. login => terautentikasi
// 2. logout => ga terautentikasi
// 3. loading => yo loading pokok
// 4. error => gagal login

sealed class AuthState {}

class AuthStateLogin extends AuthState {}

class AuthStateLoading extends AuthState {}

class AuthStateLogout extends AuthState {}

class AuthStateError extends AuthState {
  AuthStateError(this.message);
  final String message;
}
