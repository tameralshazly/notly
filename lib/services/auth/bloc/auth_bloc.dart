import 'package:bloc/bloc.dart';
import 'package:notly/services/auth/auth_provider.dart';
import 'package:notly/services/auth/auth_user.dart';
import 'package:notly/services/auth/bloc/auth_event.dart';
import 'package:notly/services/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(const AuthStateLoading()) {
    // initialize
    on<AuthEventInitialize>((event, emit) async {
      await provider.initialize();
      final user = provider.currentUser;
      if (user == null) {
        emit(const AuthStateLoggedOut());
      } else if (!user.isEmailVerified) {
        emit(const AuthStateNeedsVerification());
      } else {
        emit(AuthStateLoggedIn(user));
      }
    });
    // log in
    on<AuthEventLogIn>((event, emit) async {
      emit(const AuthStateLoading());
      final email = event.email;
      final password = event.password;

      try {
        final user = provider.logIn(
          email: email,
          password: password,
        );
        emit(AuthStateLoggedIn(user as AuthUser));
      } on Exception catch (e) {
        emit(AuthStateLoginFailure(e));
      }
    });

    // log out
    on<AuthEventLogOut>((event, emit) async {
      emit(const AuthStateLoading());

      try {
        await provider.logOut();
        emit(const AuthStateLoggedOut());
      } on Exception catch (e) {
        emit(AuthStateLogoutFailure(e));
      }
    });
  }
}
