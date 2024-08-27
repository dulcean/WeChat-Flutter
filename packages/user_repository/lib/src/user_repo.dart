import 'models/models.dart';

abstract interface class UserRepository {
  Stream<WeUser?> get user;

  Future<WeUser> signUp(
    WeUser user,
    String password,
  );

  Future<void> setUserData(
    WeUser user,
  );

  Future<void> signIn(
    String email,
    String password,
  );

  Future<void> logOut();
  Future<WeUser?> getUserById(String userId);
  String? getCurrentId();
  Future<bool> doesUserExist(String userId);
}
