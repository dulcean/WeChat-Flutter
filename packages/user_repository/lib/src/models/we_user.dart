import '../entities/entities.dart';

class WeUser {
  String userId;
  String email;
  String name;

  WeUser({
    required this.userId,
    required this.email,
    required this.name,
  });

  static final empty = WeUser(
    userId: '',
    email: '',
    name: '',
  );

  WeUserEntity toEntity() {
    return WeUserEntity(
      userId: userId,
      email: email,
      name: name,
    );
  }

  static WeUser fromEntity(WeUserEntity entity) {
    return WeUser(
      userId: entity.userId,
      email: entity.email,
      name: entity.name,
    );
  }

  @override
  String toString() => 'WeUser: $userId, $email, $name';
}
