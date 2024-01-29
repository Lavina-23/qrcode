import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthStateLogout()) {
    // kondisi awalnya tidak sedang login atau tidak terautentikasi
    FirebaseAuth auth = FirebaseAuth.instance;
    on<AuthEventLogin>((event, emit) async {
      // fungsi untuk login
      try {
        emit(AuthStateLoading()); // pake emit untuk update state
        await auth.signInWithEmailAndPassword(email: event.email, password: event.password);
        emit(AuthStateLogin());
      } on FirebaseAuthException catch (e) {
        String errorMessage = 'Email dan Password Salah !';
        if (e.code == 'user-not-found') {
          errorMessage = 'Email Anda Salah !';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Password Anda Salah !';
        }
        emit(AuthStateError(errorMessage));
      } catch (e) {
        emit(AuthStateError('Email dan Password Anda Salah !')); // pake emit untuk update state
      }
    });
    on<AuthEventLogout>((event, emit) async {
      // fungsi untuk logout
      try {
        await auth.signOut();
        emit(AuthStateLogout());
      } on FirebaseAuthException catch (e) {
        emit(AuthStateError(e.message.toString())); //
      } catch (e) {
        emit(AuthStateError(e.toString())); // pake emit untuk update state
      }
    });
  }
}
