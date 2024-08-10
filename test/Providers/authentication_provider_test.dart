// import 'package:WeChat/providers/authentication_provider.dart';
// import 'package:WeChat/utils/shared_objects.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';

// import '../mockito/mock_firebase_auth.dart';

// void main() {
//   late AuthenticationProvider authenticationProvider;
//   late MockFirebaseAuth mockFirebaseAuth;
//   late MockUser mockUser;
//   late MockCachedSharedPreferences mockCachedSharedPreferences;

//   setUp(() {
//     mockFirebaseAuth = MockFirebaseAuth();
//     mockUser = MockUser();
//     mockCachedSharedPreferences = MockCachedSharedPreferences();
//     authenticationProvider =
//         AuthenticationProvider(firebaseAuth: mockFirebaseAuth);

//     SharedObjects.sharedPreferences = mockCachedSharedPreferences;
//   });

//   test('getCurrentUser returns current user', () async {
//     when(mockFirebaseAuth.currentUser).thenReturn(mockUser);

//     final user = await authenticationProvider.getCurrentUser();
//     expect(user, equals(mockUser));
//   });

//   test('isLoggedIn returns true if user is logged in', () async {
//     when(mockFirebaseAuth.currentUser).thenReturn(mockUser);

//     final isLoggedIn = await authenticationProvider.isLoggedIn();
//     expect(isLoggedIn, true);
//   });

//   test('isLoggedIn returns false if no user is logged in', () async {
//     when(mockFirebaseAuth.currentUser).thenReturn(null);

//     final isLoggedIn = await authenticationProvider.isLoggedIn();
//     expect(isLoggedIn, false);
//   });

//   // test('signIn successful sets session UID', () async {
//   //   const email = 'test@example.com';
//   //   const password = 'password';
//   //   when(mockFirebaseAuth.signInWithEmailAndPassword(
//   //           email: email, password: password))
//   //       .thenAnswer((_) async => mockUserCredential);
//   //   when(mockUserCredential.user).thenReturn(mockUser);
//   //   when(mockUser.uid).thenReturn('test_uid');
//   //   when(mockCachedSharedPreferences.setString(
//   //           Constants.sessionUid, 'test_uid'))
//   //       .thenAnswer((_) async => Future.value());

//   //   await authenticationProvider.signIn(email, password);

//   //   verify(mockCachedSharedPreferences.setString(
//   //           Constants.sessionUid, 'test_uid'))
//   //       .called(1);
//   // });

//   // test('signOut clears session and signs out', () async {
//   //   when(mockCachedSharedPreferences.clearSession())
//   //       .thenAnswer((_) async => Future.value());

//   //   await authenticationProvider.signOut();

//   //   verify(mockCachedSharedPreferences.clearSession()).called(1);
//   //   verify(mockFirebaseAuth.signOut()).called(1);
//   // });
// }
