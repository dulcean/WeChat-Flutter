import '../user_repository.dart';

abstract class UserProfileRepository {
  Future<void> setUserProfile(WeUserProfile profile);

  Future<WeUserProfileEntity?> getUserProfile(String userId);

  Future<void> updateUserProfile(
    String userId, {
    String? photoUrl,
    String? description,
    String? weTag,
  });

  Future<String> uploadPicture(String file, String userId);

  Future<bool> doesUserProfileExist(String userId);

  Stream<WeUserProfileEntity?> getUserProfileStream(String userId);

  Future<String?> getUserIdByWeTag(String weTag);
}
