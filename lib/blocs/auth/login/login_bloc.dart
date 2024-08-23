import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;

  LoginBloc(
    this._userRepository,
  ) : super(LoginInitial()) {
    on<LoginRequired>((event, emit) async {
      emit(LoginProcess());
      try {
        emit(LoginProcess());
        await _userRepository.signIn(
          event.email,
          event.password,
        );
        emit(LoginSuccess());
      } catch (e) {
        emit(LoginFailure());
      }
    });

    on<LogOutRequired>(
      (event, emit) => _userRepository.logOut(),
    );
  }
}
