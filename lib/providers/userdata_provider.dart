// import 'package:WeChat/utils/doc_snapshot.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import '../configs/constants.dart';
// import '../configs/paths.dart';
// import '../models/user_dto.dart';
// import '../utils/shared_objects.dart';
// import 'base_providers.dart';

// class UserDataProvider extends BaseUserDataProvider {
//   final FirebaseFirestore fireStoreDB;

//   UserDataProvider({FirebaseFirestore? fireStoreDB})
//       : fireStoreDB = fireStoreDB ?? FirebaseFirestore.instance;

//   @override
//   void dispose() {}

//   @override
//   Future<bool> isProfileComplete(String uid) async {
//     DocumentReference ref = fireStoreDB
//         .collection(Paths.usersPath)
//         .doc(SharedObjects.sharedPreferences!.getString(Constants.sessionUid));
//     final DocumentSnapshot currentDocument = await ref.get();
//     final bool isProfileComplete = currentDocument.exists &&
//         currentDocument.dataAsMap.containsKey('photoUrl') &&
//         currentDocument.dataAsMap.containsKey('username');
//     if (isProfileComplete) {
//       await SharedObjects.sharedPreferences!.setString(
//           Constants.sessionUsername, currentDocument.dataAsMap['username']);
//       await SharedObjects.sharedPreferences!
//           .setString(Constants.sessionName, currentDocument.dataAsMap['name']);
//       await SharedObjects.sharedPreferences!.setString(
//           Constants.sessionProfilePictureUrl,
//           currentDocument.dataAsMap['photoUrl']);
//     }
//     return isProfileComplete;
//   }

//   @override
//   Future<UserDTO> saveDetailsFromAuth(User user) async {
//     DocumentReference ref =
//         fireStoreDB.collection(Paths.usersPath).doc(user.uid);
//     final bool userExists = !await ref.snapshots().isEmpty;
//     var data = {
//       'uid': user.uid,
//       'email': user.email,
//       'name': user.displayName,
//     };
//     if (!userExists && user.photoURL != null) {
//       data['photoUrl'] = user.photoURL;
//     }
//     ref.set(data, SetOptions(merge: true));
//     final DocumentSnapshot currentDocument = await ref.get();
//     await SharedObjects.sharedPreferences!
//         .setString(Constants.sessionUsername, data['name']!);
//     return UserDTO.fromFirestore(currentDocument);
//   }

//   @override
//   Future<UserDTO> saveProfileDetails(
//       String profileImageUrl, String username) async {
//     String? uid =
//         SharedObjects.sharedPreferences!.getString(Constants.sessionUid);
//     DocumentReference mapReference =
//         fireStoreDB.collection(Paths.usernameUidMapPath).doc(username);
//     var mapData = {'uid': uid};
//     mapReference.set(mapData);

//     DocumentReference ref = fireStoreDB.collection(Paths.usersPath).doc(uid);
//     var data = {
//       'photoUrl': profileImageUrl,
//       'username': username,
//     };

//     await ref.set(data, SetOptions(merge: true));
//     final DocumentSnapshot currentDocument = await ref.get();
//     await SharedObjects.sharedPreferences!
//         .setString(Constants.sessionUsername, username);
//     await SharedObjects.sharedPreferences!.setString(
//         Constants.sessionProfilePictureUrl,
//         currentDocument.dataAsMap['photoUrl']);
//     return UserDTO.fromFirestore(currentDocument);
//   }
// }
