class WeUserFriendsEntity {
  String userId;
  List<String> friends;

  WeUserFriendsEntity({
    required this.userId,
    required this.friends,
  });

  Map<String, dynamic> toDocument() {
    return {
      'userId': userId,
      'friends': friends,
    };
  }

  static WeUserFriendsEntity fromDocument(Map<String, dynamic> doc) {
    return WeUserFriendsEntity(
      userId: doc['userId'] as String,
      friends: doc['friends'] as List<String>,
    );
  }
}
