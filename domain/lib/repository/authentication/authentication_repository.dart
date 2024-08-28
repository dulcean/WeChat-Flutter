import 'package:data/data.dart';

abstract class AuthenticationRepository {
  Stream<WeUserModel?> get user;
  Future<WeUserModel> signUp(
    WeUserModel user,
    String password,
  );
  Future<void> setUserData(
    WeUserModel user,
  );
  Future<void> signIn(
    String email,
    String password,
  );
  Future<void> logOut();
  Future<WeUserModel?> getUserById(String userId);
  String? getCurrentId();
  Future<bool> doesUserExist(String userId);
}
