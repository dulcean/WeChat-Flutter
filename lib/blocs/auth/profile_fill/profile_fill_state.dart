part of 'profile_fill_bloc.dart';

sealed class ProfileFillState extends Equatable {
  const ProfileFillState();

  @override
  List<Object> get props => [];
}

final class ProfileFillInitial extends ProfileFillState {}

final class ProfileFillSuccess extends ProfileFillState {
  final String imagePath;
  final String weTag;

  const ProfileFillSuccess(this.imagePath, this.weTag);

  @override
  List<Object> get props => [imagePath, weTag];
}

final class ProfileFillFailure extends ProfileFillState {}

final class ProfileFillUpdateInProgress extends ProfileFillState {}

class ProfileImageSelectionInProgress extends ProfileFillState {}

class ProfileImageSelectionSuccess extends ProfileFillState {
  final String imagePath;

  const ProfileImageSelectionSuccess(this.imagePath);

  @override
  List<Object> get props => [imagePath];
}

class ProfileImageSelectionFailure extends ProfileFillState {
  final String error;

  const ProfileImageSelectionFailure(this.error);

  @override
  List<Object> get props => [error];
}
