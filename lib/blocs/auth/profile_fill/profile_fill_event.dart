part of 'profile_fill_bloc.dart';

abstract class ProfileFillEvent extends Equatable {
  const ProfileFillEvent();

  @override
  List<Object?> get props => [];
}

class ProfileUpdateRequested extends ProfileFillEvent {
  final String userId;
  final String weTag;
  final String imagePath;

  const ProfileUpdateRequested({
    required this.userId,
    required this.weTag,
    required this.imagePath,
  });

  @override
  List<Object?> get props => [userId, weTag, imagePath];
}

class ProfileImageSelected extends ProfileFillEvent {
  final ImageSource imageSource;

  const ProfileImageSelected(this.imageSource);

  @override
  List<Object?> get props => [imageSource];
}
