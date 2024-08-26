import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_repository/user_repository.dart';

class FirebaseUserFriendsRepository implements UserFriendsRepository {
  final userRepo = FirebaseUserRepository();
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
  Future<void> acceptFriendRequest(String friendId) async {
    try {
      final userId = userRepo.getCurrentId();
      final friendsRequestDoc =
          await _friendRequests.doc('${userId}_$friendId').get();

      if (friendsRequestDoc.exists) {
        final userFriendsDoc = await _friendsCollection.doc(userId).get();
        if (userFriendsDoc.exists) {
          await _friendsCollection.doc(userId).update({
            'friends': FieldValue.arrayUnion([friendId])
          });
        } else {
          await _friendsCollection.doc(userId).set({
            'friends': [friendId]
          });
        }
        final friendDoc = await _friendsCollection.doc(friendId).get();
        if (friendDoc.exists) {
          await _friendsCollection.doc(friendId).update({
            'friends': FieldValue.arrayUnion([userId]),
          });
        } else {
          await _friendsCollection.doc(friendId).set({
            'friends': [userId]
          });
        }
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
  Future<void> rejectFriendRequest(String friendId) async {
    try {
      final userId = userRepo.getCurrentId();
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
        if (doc.id != userRepo.getCurrentId()) userIds.add(doc.id);
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
  Future<void> sendFriendRequest(String friendId) async {
    try {
      String? userId = userRepo.getCurrentId();
      final friendsDoc = await _friendsCollection.doc(userId).get();
      if (friendsDoc.exists) {
        final friends = (friendsDoc.data() as Map<String, dynamic>)['friends']
            as List<dynamic>;
        if (friends.contains(friendId)) {
          log('You are already friends with this user.');
          return;
        }
      }
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

  @override
  Future<List<String>> getPendingFriendRequestUserIds(
      String currentUserId) async {
    try {
      final querySnapshot = await _friendRequests.get();

      return querySnapshot.docs.map((doc) {
        return doc['friendId'] as String;
      }).toList();
    } catch (e) {
      throw Exception('Error fetching friend requests: $e');
    }
  }
}
