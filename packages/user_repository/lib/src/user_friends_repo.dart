import '../user_repository.dart';

abstract interface class UserFriendsRepository {
  Future<WeUserFriendsEntity?> getFriendsList(String userId);
  Future<void> sendFriendRequest(String userId, String friendId);
  Future<void> acceptFriendRequest(String userId, String friendId);
  Future<void> rejectFriendRequest(String userId, String friendId);
  Future<void> removeFriend(String userId, String friendId);
  Future<List<String>> searchUsers(String query);
}
