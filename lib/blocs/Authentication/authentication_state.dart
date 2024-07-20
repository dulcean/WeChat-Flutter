part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();
  
  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

class Uninitialized extends AuthenticationState{
  @override
  String toString() => 'Uninitialized';
}

class AuthInProgress extends AuthenticationState{
  @override
  String toString() => 'AuthInProgress';
}

class Authenticated extends AuthenticationState{
  final User user;
  Authenticated(this.user);
  @override
  String toString() => 'Authenticated';
}

class PreFillData extends AuthenticationState{
  final User user;
  PreFillData(this.user);
  @override
  String toString() => 'PreFillData';
}

class UnAuthenticated extends AuthenticationState{
  @override
  String toString() => 'UnAuthenticated';
}

class ReceivedProfilePicture extends AuthenticationState{
  final File file;
  ReceivedProfilePicture(this.file);
  @override toString() => 'ReceivedProfilePicture';
}

class ProfileUpdateInProgress extends AuthenticationState{
  @override
  String toString() => 'ProfileUpdateInProgress';
}

class ProfileUpdated extends AuthenticationState{
  @override
  String toString() => 'ProfileComplete';
}