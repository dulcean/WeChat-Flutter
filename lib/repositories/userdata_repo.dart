import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_dto.dart';
import '../providers/base_providers.dart';
import '../providers/userdata_provider.dart';

class UserDataRepository {
  BaseUserDataProvider userDataProvider = UserDataProvider();

  Future<UserDTO> saveDetailsFromAuth(User user) =>
      userDataProvider.saveDetailsFromAuth(user);

  Future<UserDTO> saveProfileDetails(
          String profileImageUrl, String username) =>
      userDataProvider.saveProfileDetails(profileImageUrl, username);

  Future<bool> isProfileComplete(String uid) =>
      userDataProvider.isProfileComplete(uid);
}