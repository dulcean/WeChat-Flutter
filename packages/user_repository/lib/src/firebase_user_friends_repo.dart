import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_repository/src/entities/we_user_friends_entity.dart';
import 'package:user_repository/src/user_friends_repo.dart';

class FirebaseUserFriendsRepository implements UserFriendsRepository {
  final _usersCollection = FirebaseFirestore.instance.collection('users');
  final _userProfilesCollection =
      FirebaseFirestore.instance.collection('user_profiles');
  final _friendsCollection =
      FirebaseFirestore.instance.collection('user_friends');
  final _friendRequests =
      FirebaseFirestore.instance.collection('friend_requests');
  final _friendshipReject =
      FirebaseFirestore.instance.collection('friendship_reject');

  @override
  Future<void> acceptFriendRequest(String userId, String friendId) async {
    try {
      final friendsRequestDoc =
          await _friendRequests.doc('${userId}_$friendId').get();
      if (friendsRequestDoc.exists) {
        await _friendsCollection.doc(userId).update({
          'friends': FieldValue.arrayUnion([friendId])
        });
        await _friendsCollection.doc(friendId).update({
          'friends': FieldValue.arrayUnion([userId]),
        });
        await _friendRequests.doc('${userId}_$friendId').delete();
        await _friendRequests.doc('${friendId}_$userId').delete();
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<WeUserFriendsEntity?> getFriendsList(String userId) async {
    try {
      final docSnapshot = await _friendsCollection.doc(userId).get();
      if (docSnapshot.exists) {
        final friendsList = docSnapshot.data()?['friends'] as List<dynamic>?;
        if (friendsList != null) {
          return WeUserFriendsEntity(
            userId: userId,
            friends: friendsList.cast<String>(),
          );
        }
      }
      return WeUserFriendsEntity(userId: userId, friends: []);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> rejectFriendRequest(String userId, String friendId) async {
    try {
      final friendRequestDoc =
          await _friendRequests.doc('${userId}_$friendId').get();
      if (friendRequestDoc.exists) {
        await _friendshipReject.doc('${userId}_$friendId').set({
          'rejectedAt': Timestamp.now(),
          'expiresAt': Timestamp.fromDate(
            DateTime.now().add(
              const Duration(
                hours: 48,
              ),
            ),
          ),
        });
        await _friendRequests.doc('${userId}_$friendId').delete();
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> removeFriend(String userId, String friendId) async {
    try {
      await _friendsCollection.doc(userId).update({
        'friends': FieldValue.arrayRemove([friendId]),
      });
      await _friendsCollection.doc(friendId).update({
        'friends': FieldValue.arrayRemove([userId]),
      });

      log('Friend removed successfully');
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<String>> searchUsers(String query) async {
    try {
      final nameResults = await _usersCollection
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThanOrEqualTo: '$query\uf8ff')
          .get();

      final weTagResults = await _userProfilesCollection
          .where('weTag', isGreaterThanOrEqualTo: query)
          .where('weTag', isLessThanOrEqualTo: '$query\uf8ff')
          .get();

      final userIds = <String>{};

      for (var doc in nameResults.docs) {
        userIds.add(doc.id);
      }

      for (var doc in weTagResults.docs) {
        userIds.add(doc.id);
      }

      return userIds.toList();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> sendFriendRequest(String userId, String friendId) async {
    try {
      final existingRequest = await _friendRequests
          .where('userId', isEqualTo: userId)
          .where('friendId', isEqualTo: friendId)
          .get();
      if (existingRequest.docs.isNotEmpty) {
        log('Friend request already sent. Please check your friend requests.');
        return;
      }
      final reciprocalRequest = await _friendRequests
          .where('userId', isEqualTo: friendId)
          .where('friendId', isEqualTo: userId)
          .get();
      if (reciprocalRequest.docs.isNotEmpty) {
        log('Friend request already received. Please check your friend requests.');
        return;
      }
      final rejectedRequest =
          await _friendshipReject.doc('${friendId}_$userId').get();
      if (rejectedRequest.exists &&
          (rejectedRequest['expiresAt'] as Timestamp)
              .toDate()
              .isAfter(DateTime.now())) {
        log('Cannot send friend request. Please try again later.');
        return;
      }
      await _friendRequests.doc('${userId}_$friendId').set({
        'userId': userId,
        'friendId': friendId,
        'sentAt': Timestamp.now(),
      });
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
