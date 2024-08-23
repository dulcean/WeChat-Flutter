import '../entities/we_user_profile_entity.dart';

class WeUserProfile {
  String userId;
  String photoUrl;
  String description;
  String weTag;

  WeUserProfile({
    required this.userId,
    required this.photoUrl,
    this.description = '',
    required this.weTag,
  });

  WeUserProfileEntity toEntity() {
    return WeUserProfileEntity(
      userId: userId,
      photoUrl: photoUrl,
      description: description,
      weTag: weTag,
    );
  }

  static WeUserProfile fromEntity(WeUserProfileEntity entity) {
    return WeUserProfile(
      userId: entity.userId,
      photoUrl: entity.photoUrl,
      description: entity.description,
      weTag: entity.weTag,
    );
  }

  @override
  String toString() {
    return 'WeUserProfile(userId: $userId, photoUrl: $photoUrl, description: $description, weTag: $weTag)';
  }
}
