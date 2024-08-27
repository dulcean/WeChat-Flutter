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
      if (userId == null) {
        throw Exception('User ID cannot be null');
      }

      final userRequestsDoc = await _friendRequests.doc(userId).get();

      if (userRequestsDoc.exists) {
        final receivedRequests = List<String>.from(
            userRequestsDoc.data()?['receivedRequests'] ?? []);
        if (receivedRequests.contains(friendId)) {
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

          await _friendRequests.doc(userId).update({
            'receivedRequests': FieldValue.arrayRemove([friendId]),
          });
          await _friendRequests.doc(friendId).update({
            'sentRequests': FieldValue.arrayRemove([userId]),
          });

          log('Friend request accepted successfully.');
        } else {
          log('No friend request found from this user.');
        }
      } else {
        log('No friend requests found.');
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
      if (userId == null) {
        throw Exception('User ID cannot be null');
      }
      final requestDocId = '${userId}_$friendId';
      await _friendshipReject.doc(requestDocId).set({
        'rejectedAt': Timestamp.now(),
        'expiresAt': Timestamp.fromDate(
          DateTime.now().add(const Duration(hours: 48)),
        ),
      });
      await _friendRequests.doc(requestDocId).delete();
      await _friendRequests.doc(friendId).update({
        'sentRequests': FieldValue.arrayRemove([userId]),
      });
      await _friendRequests.doc(userId).update({
        'receivedRequests': FieldValue.arrayRemove([friendId]),
      });

      log('Friend request rejected and removed successfully.');
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
      if (userId == null) {
        throw Exception('User ID cannot be null');
      }
      final friendsDoc = await _friendsCollection.doc(userId).get();
      if (friendsDoc.exists) {
        final friends = (friendsDoc.data() as Map<String, dynamic>)['friends']
            as List<dynamic>;
        if (friends.contains(friendId)) {
          log('You are already friends with this user.');
          return;
        }
      }
      final friendRequestsDoc = await _friendRequests.doc(userId).get();
      final data = friendRequestsDoc.data();
      final friendRequests =
          data != null && data['sentRequests'] is List<dynamic>
              ? List<String>.from(data['sentRequests'] as List<dynamic>)
              : [];

      if (friendRequests.contains(friendId)) {
        log('Friend request already sent. Please check your friend requests.');
        return;
      }

      final receivedRequestsDoc = await _friendRequests.doc(friendId).get();
      final dataX = receivedRequestsDoc.data();
      final receivedRequests =
          (dataX != null && dataX['receivedRequests'] != null)
              ? List<String>.from(dataX['receivedRequests'] as List<dynamic>)
              : [];

      if (receivedRequests.contains(userId)) {
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

      await _friendRequests.doc(userId).set({
        'sentRequests': FieldValue.arrayUnion([friendId]),
      }, SetOptions(merge: true));

      await _friendRequests.doc(friendId).set({
        'receivedRequests': FieldValue.arrayUnion([userId]),
      }, SetOptions(merge: true));

      log('Friend request sent successfully.');
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<String>> getPendingFriendRequestUserIds(
      String currentUserId) async {
    try {
      final doc = await _friendRequests.doc(currentUserId).get();

      if (doc.exists) {
        final receivedRequests =
            List<String>.from(doc.data()?['receivedRequests'] ?? []);

        return receivedRequests;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Error fetching pending friend requests: $e');
    }
  }
}
