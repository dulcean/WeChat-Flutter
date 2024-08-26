import '../user_repository.dart';

abstract interface class UserFriendsRepository {
  Future<WeUserFriendsEntity?> getFriendsList(String userId);
  Future<void> sendFriendRequest(String friendId);
  Future<void> acceptFriendRequest(String friendId);
  Future<void> rejectFriendRequest(String friendId);
  Future<void> removeFriend(String userId, String friendId);
  Future<List<String>> searchUsers(String query);
  Future<List<String>> getPendingFriendRequestUserIds(String currentUserId);
}
