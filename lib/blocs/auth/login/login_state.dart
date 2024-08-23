part of 'login_bloc.dart';

enum LoginStatus {
  initial,
  loading,
  success,
  error,
}

class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}
final class LoginFailure extends LoginState {}
final class LoginProcess extends LoginState {}
final class LoginSuccess extends LoginState {}
