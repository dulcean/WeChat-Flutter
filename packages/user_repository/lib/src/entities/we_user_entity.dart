class WeUserEntity {
  String userId;
  String email;
  String name;

  WeUserEntity({
    required this.userId,
    required this.email,
    required this.name,
  });

  Map<String, dynamic> toDocument() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
    };
  }

  static WeUserEntity fromDocument(Map<String, dynamic> doc) {
    return WeUserEntity(
      userId: doc['userId'],
      email: doc['email'],
      name: doc['name'],
    );
  }
}
