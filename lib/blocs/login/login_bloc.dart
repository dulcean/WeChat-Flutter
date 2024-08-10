import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginApi>(_loginApi);
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    emit(
      state.copyWith(
        email: event.email,
      ),
    );
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    emit(
      state.copyWith(
        password: event.password,
      ),
    );
  }

  void _loginApi(LoginApi event, Emitter<LoginState> emit) async {
    try {
      FirebaseAuth.instance.signInWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
    } on FirebaseAuthException catch (e) {
      emit(
        state.copyWith(
          message: e.toString(),
        ),
      );
    }
  }
}
