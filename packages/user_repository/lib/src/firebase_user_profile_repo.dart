import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../user_repository.dart';

class FirebaseUserProfileRepository implements UserProfileRepository {
  final _profileCollection =
      FirebaseFirestore.instance.collection('user_profiles');

  @override
  Future<void> setUserProfile(
    WeUserProfile userProfile,
  ) async {
    try {
      await _profileCollection.doc(userProfile.userId).set(
            userProfile.toEntity().toDocument(),
          );
    } catch (e) {
      log('Error updating user profile: $e');
      rethrow;
    }
  }

  @override
  Future<bool> doesUserProfileExist(String userId) async {
    final doc = await _profileCollection.doc(userId).get();
    return doc.exists;
  }

  @override
  Future<WeUserProfileEntity?> getUserProfile(String userId) async {
    try {
      final docSnapshot = await _profileCollection.doc(userId).get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>?;
        if (data != null) {
          return WeUserProfileEntity.fromDocument(data);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> updateUserProfile(String userId,
      {String? photoUrl, String? description, String? weTag}) async {
    try {
      final updates = <String, dynamic>{};
      if (photoUrl != null) updates['photoUrl'] = photoUrl;
      if (description != null) updates['description'] = description;
      if (weTag != null) updates['weTag'] = weTag;

      await _profileCollection.doc(userId).update(updates);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Stream<WeUserProfileEntity?> getUserProfileStream(String userId) {
    return _profileCollection.doc(userId).snapshots().map((snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>?;
        if (data != null) {
          return WeUserProfileEntity.fromDocument(data);
        } else {
          return null;
        }
      } else {
        return null;
      }
    });
  }

  Future<bool> isProfileComplete(String userId) async {
    try {
      final docSnapshot = await _profileCollection.doc(userId).get();
      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        final photoUrl = data['photoUrl'];
        final weTag = data['weTag'];
        return photoUrl != null &&
            photoUrl.isNotEmpty &&
            weTag != null &&
            weTag.isNotEmpty;
      }
      return false;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<String> uploadPicture(String file, String userId) async {
    try {
      File imageFile = File(file);

      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('$userId/PP/${userId}_lead');
      await firebaseStorageRef.putFile(imageFile);
      String url = await firebaseStorageRef.getDownloadURL();
      await _profileCollection.doc(userId).update({'photoUrl': url});
      return url;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
