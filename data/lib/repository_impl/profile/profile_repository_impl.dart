import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/constants/text_constants.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:firebase_storage/firebase_storage.dart';

final class ProfileRepositoryImpl implements ProfileRepository {
  final _profileCollection =
      FirebaseFirestore.instance.collection('user_profiles');

  @override
  Future<bool> doesUserProfileExist(String userId) async {
    final doc = await _profileCollection.doc(userId).get();
    return doc.exists;
  }

  @override
  Future<String?> getUserIdByWeTag(String weTag) async {
    try {
      final querySnapshot = await _profileCollection
          .where('weTag', isEqualTo: weTag)
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<WeUserProfileModel?> getUserProfile(String userId) async {
    try {
      final docSnapshot = await _profileCollection.doc(userId).get();
      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        if (data != null) {
          return WeUserProfileModel.fromMap(data);
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
  Stream<WeUserProfileModel?> getUserProfileStream(String userId) {
    return _profileCollection.doc(userId).snapshots().map((snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data();
        if (data != null) {
          return WeUserProfileModel.fromMap(data);
        } else {
          return null;
        }
      } else {
        return null;
      }
    });
  }

  @override
  Future<bool> isProfileComplete(String userId) async {
    try {
      final docSnapshot = await _profileCollection.doc(userId).get();
      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        log('${TextConstants().profileData} $data');
        final photoUrl = data['photoUrl'];
        final weTag = data['weTag'];
        final isComplete = photoUrl != null &&
            photoUrl.isNotEmpty &&
            weTag != null &&
            weTag.isNotEmpty;
        log('${TextConstants().complete} $isComplete');
        return isComplete;
      } else {
        log('${TextConstants().noSuchUserProfile} $userId');
        return false;
      }
    } catch (e) {
      log('${TextConstants().errorInProfile} ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<void> setUserProfile(WeUserProfileModel profile) async {
    try {
      await _profileCollection.doc(profile.userId).set(
            profile.toEntity().toMap(),
          );
    } catch (e) {
      log('${TextConstants().errorInProfile} $e');
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
