import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_repository/user_repository.dart';

part 'profile_fill_event.dart';
part 'profile_fill_state.dart';

class ProfileFillBloc extends Bloc<ProfileFillEvent, ProfileFillState> {
  final UserProfileRepository _userProfileRepository;
  final ImagePicker _imagePicker = ImagePicker();

  ProfileFillBloc({
    required UserProfileRepository userProfileRepository,
  })  : _userProfileRepository = userProfileRepository,
        super(ProfileFillInitial()) {
    on<ProfileUpdateRequested>(_onProfileUpdateRequested);
    on<ProfileImageSelected>(_onProfileImageSelected);
  }

  Future<void> _onProfileUpdateRequested(
      ProfileUpdateRequested event, Emitter<ProfileFillState> emit) async {
    emit(ProfileFillUpdateInProgress());
    try {
      final userProfileExists =
          await _userProfileRepository.doesUserProfileExist(event.userId);
      if (!userProfileExists) {
        await _userProfileRepository.setUserProfile(
            WeUserProfile(userId: event.userId, photoUrl: '', weTag: event.weTag));
      }
      final photoUrl = await _userProfileRepository.uploadPicture(
        event.imagePath,
        event.userId,
      );
      emit(ProfileFillSuccess(photoUrl, event.weTag));
    } catch (e) {
      log(e.toString());
      emit(ProfileFillFailure());
    }
  }

  Future<void> _onProfileImageSelected(
      ProfileImageSelected event, Emitter<ProfileFillState> emit) async {
    emit(ProfileImageSelectionInProgress());
    try {
      final pickedFile =
          await _imagePicker.pickImage(source: event.imageSource);
      if (pickedFile != null) {
        emit(ProfileImageSelectionSuccess(pickedFile.path));
      } else {
        emit(const ProfileImageSelectionFailure("No image selected"));
      }
    } catch (e) {
      emit(ProfileImageSelectionFailure("Failed to pick image: $e"));
    }
  }
}
