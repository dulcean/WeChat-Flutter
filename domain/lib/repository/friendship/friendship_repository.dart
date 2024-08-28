import 'package:domain/domain.dart';

abstract class FriendshipRepository {
  Future<WeUserFriends?> getFriendsList(String userId);
  Future<void> sendFriendRequest(String friendId);
  Future<void> acceptFriendRequest(String friendId);
  Future<void> rejectFriendRequest(String friendId);
  Future<void> removeFriend(String userId, String friendId);
  Future<List<String>> searchUsers(String query);
  Future<List<String>> getPendingFriendRequestUserIds(String currentUserId);
}
