import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/models/we_user_model.dart';
import 'package:domain/domain.dart';
import 'package:firebase_auth/firebase_auth.dart';

final class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final FirebaseAuth _firebaseAuth;
  final userCollection = FirebaseFirestore.instance.collection('users');

  AuthenticationRepositoryImpl({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<bool> doesUserExist(String userId) async {
    try {
      final userDoc = await userCollection.doc(userId).get();
      return userDoc.exists;
    } catch (e) {
      log('Error checking user existence: $e');
      return false;
    }
  }

  @override
  String? getCurrentId() {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  @override
  Future<WeUserModel?> getUserById(String userId) async {
    try {
      final userDocument = await userCollection.doc(userId).get();
      if (userDocument.exists) {
        final userEntity = WeUser.fromMap(userDocument.data()!);
        return WeUserModel(
          userId: userEntity.userId,
          email: userEntity.email,
          name: userEntity.name,
        );
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
    return null;
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> setUserData(WeUserModel user) async {
    try {
      await userCollection.doc(user.userId).set(
            user.toEntity(user).toMap(),
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
  Future<WeUserModel> signUp(WeUserModel user, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );
      final weUser = WeUserModel(
        userId: userCredential.user!.uid,
        email: user.email,
        name: user.name,
      );
      return weUser;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Stream<WeUserModel> get user {
    return _firebaseAuth.authStateChanges().asyncExpand((firebaseUser) async* {
      if (firebaseUser == null) {
        yield WeUserModel.empty();
      } else {
        final userDocument = await userCollection.doc(firebaseUser.uid).get();
        if (userDocument.exists && userDocument.data() != null) {
          final userEntity = WeUser.fromMap(userDocument.data()!);
          yield WeUserModel.fromEntity(userEntity);
        } else {
          yield WeUserModel.empty();
        }
      }
    });
  }
}
