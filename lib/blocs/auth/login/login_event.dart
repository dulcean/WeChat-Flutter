part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginRequired extends LoginEvent {
  final String email;
  final String password;

  const LoginRequired(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class LogOutRequired extends LoginEvent {}

class EmailChanged extends LoginEvent {
  final String email;
  const EmailChanged({
    required this.email,
  });

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends LoginEvent {
  final String password;
  const PasswordChanged({
    required this.password,
  });

  @override
  List<Object> get props => [password];
}

class LoginApi extends LoginEvent {}
