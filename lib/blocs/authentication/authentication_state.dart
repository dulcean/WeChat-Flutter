part of 'authentication_bloc.dart';

enum AuthenticationStatus {
  authenticated,
  unauthenticated,
  unknown,
}

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user,
  });
  // const AuthenticationState(this.user, {required this.status});

  final AuthenticationStatus status;
  final WeUser? user;

  const AuthenticationState.unknown() : this._();
  const AuthenticationState.authenticated(WeUser weUser)
      : this._(
          status: AuthenticationStatus.authenticated,
          user: weUser,
        );
  const AuthenticationState.unauthenticated()
      : this._(
          status: AuthenticationStatus.unauthenticated,
        );

  @override
  List<Object?> get props => [status, user];
}
