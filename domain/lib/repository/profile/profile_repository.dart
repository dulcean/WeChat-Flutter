import 'package:data/data.dart';

abstract class ProfileRepository {
  Future<void> setUserProfile(WeUserProfileModel profile);
  Future<WeUserProfileModel?> getUserProfile(String userId);
  Future<void> updateUserProfile(
    String userId, {
    String? photoUrl,
    String? description,
    String? weTag,
  });
  Future<String> uploadPicture(String file, String userId);
  Future<bool> doesUserProfileExist(String userId);
  Stream<WeUserProfileModel?> getUserProfileStream(String userId);
  Future<String?> getUserIdByWeTag(String weTag);
  Future<bool> isProfileComplete(String userId);
}