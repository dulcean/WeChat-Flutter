import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/user_repository.dart';

class FirebaseUserRepository implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  final userCollection = FirebaseFirestore.instance.collection('users');

  FirebaseUserRepository({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> setUserData(WeUser user) async {
    try {
      await userCollection.doc(user.userId).set(
            user.toEntity().toDocument(),
          );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<WeUser> signUp(WeUser user, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );

      user.userId = userCredential.user!.uid;
      return user;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Stream<WeUser?> get user {
    return _firebaseAuth.authStateChanges().asyncExpand((firebaseUser) async* {
      if (firebaseUser == null) {
        yield WeUser.empty;
      } else {
        final userDocument = await userCollection.doc(firebaseUser.uid).get();
        final userEntity = WeUserEntity.fromDocument(userDocument.data()!);
        yield WeUser.fromEntity(userEntity);
      }
    });
  }

  @override
  Future<WeUser?> getUserById(String userId) async {
    try {
      final userDocument = await userCollection.doc(userId).get();
      if (userDocument.exists) {
        final userEntity = WeUserEntity.fromDocument(userDocument.data()!);
        return WeUser.fromEntity(userEntity);
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
    return null;
  }

  @override
  String? getCurrentId() {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }
}
