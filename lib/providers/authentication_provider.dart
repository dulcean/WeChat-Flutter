// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// import '../configs/constants.dart';
// import '../utils/shared_objects.dart';
// import 'base_providers.dart';

// class AuthenticationProvider extends BaseAuthenticationProvider {
//   final FirebaseAuth firebaseAuth;
//   final FlutterSecureStorage secureStorage;

//   AuthenticationProvider(
//       {FirebaseAuth? firebaseAuth, FlutterSecureStorage? secureStorage})
//       : firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
//         secureStorage = secureStorage ?? FlutterSecureStorage();

//   @override
//   void dispose() {}

//   @override
//   Future<User?> getCurrentUser() async {
//     return firebaseAuth.currentUser;
//   }

//   @override
//   Future<bool> isLoggedIn() async {
//     final user = firebaseAuth.currentUser;
//     return user != null;
//   }

//   @override
//   Future<User?> signIn(
//     String email,
//     String password,
//   ) async {
//     try {
//       final UserCredential userCredential =
//           await firebaseAuth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       final User? user = userCredential.user;
//       if (user != null) {
//         await SharedObjects.sharedPreferences!
//             .setString(Constants.sessionUid, user.uid);
//         print(
//             'Session UID ${SharedObjects.sharedPreferences!.getString(Constants.sessionUid)}');
//         await secureStorage.write(key: 'password', value: password);
//       }
//       return user;
//     } catch (e) {
//       print('Error signing in with email / password');
//       rethrow;
//     }
//   }

//   @override
//   Future<void> signOut() async {
//     await SharedObjects.sharedPreferences!.clearSession();
//     await Future.wait([firebaseAuth.signOut()]);
//     await secureStorage.delete(key: 'password');
//   }
// }
