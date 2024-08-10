// import 'dart:io';

// import 'package:firebase_auth/firebase_auth.dart';

// import '../models/user_dto.dart';

// abstract class BaseProvider {
//   void dispose();
// }

// abstract class BaseAuthenticationProvider extends BaseProvider {
//   Future<User?> signIn(
//     String email,
//     String password,
//   );
//   Future<void> signOut();
//   Future<User?> getCurrentUser();
//   Future<bool> isLoggedIn();
// }

// abstract class BaseUserDataProvider extends BaseProvider {
//   Future<UserDTO> saveDetailsFromAuth(User user);
//   Future<UserDTO> saveProfileDetails(
//     String profileImageUrl,
//     String username,
//   );
//   Future<bool> isProfileComplete(String uid);
// }

// abstract class BaseStorageProvider extends BaseProvider {
//   Future<String> uploadImage(File file, String path); 
// }

// abstract class BaseChatProvider extends BaseProvider {
//   //TODO Chats
// }

// abstract class BaseDeviceStorageProvider extends BaseProvider {
//   //TODO For mems
// }
