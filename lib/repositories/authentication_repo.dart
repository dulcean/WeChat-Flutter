import 'package:firebase_auth/firebase_auth.dart';

import '../providers/authentication_provider.dart';
import '../providers/base_providers.dart';

class AuthenticationRepository {
  BaseAuthenticationProvider authenticationProvider = AuthenticationProvider();

  Future<User?> signIn(String email, String password) =>
      authenticationProvider.signIn(email, password);

  Future<void> signOut() => authenticationProvider.signOut();

  Future<User?> getCurrentUser() => authenticationProvider.getCurrentUser();

  Future<bool> isLoggedIn() => authenticationProvider.isLoggedIn();
}
