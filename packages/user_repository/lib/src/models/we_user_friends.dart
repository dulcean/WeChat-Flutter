import '../entities/we_user_friends_entity.dart';

class WeUserFriends {
  String userId;
  List<String> friends;

  WeUserFriends({
    required this.userId,
    required this.friends,
  });

  WeUserFriendsEntity toEntity() {
    return WeUserFriendsEntity(
      userId: userId,
      friends: friends,
    );
  }

  static WeUserFriends fromEntity(WeUserFriendsEntity entity) {
    return WeUserFriends(
      userId: entity.userId,
      friends: entity.friends,
    );
  }

  @override
  String toString() =>
      'WeUserFriends(userId: $userId, friendsList: $friends)';

  WeUserFriends copyWith({
    String? userId,
    List<String>? friendsList,
  }) {
    return WeUserFriends(
      userId: userId ?? this.userId,
      friends: friendsList ?? this.friends,
    );
  }
}
