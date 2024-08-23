class WeUserProfileEntity {
  String userId;
  String photoUrl;
  String description;
  String weTag;

  static const defaultPhotoUrl =
      'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.forbes.com%2Fsites%2Fceciliarodriguez%2F2020%2F11%2F12%2Fworld-best-photos-of-animals-20-winning-images-by-agora%2F&psig=AOvVaw3rfVrS3V3DfMF9iVgEfUfb&ust=1723634200103000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCNDo0Pzr8YcDFQAAAAAdAAAAABAE';
  static const defaultDescription = 'No description provided';

  WeUserProfileEntity({
    required this.userId,
    required this.weTag,
    this.photoUrl = defaultPhotoUrl,
    this.description = defaultDescription,
  });

  Map<String, dynamic> toDocument() {
    return {
      'userId': userId,
      'photoUrl': photoUrl,
      'description': description,
      'weTag': weTag,
    };
  }

  static WeUserProfileEntity fromDocument(Map<String, dynamic> doc) {
    return WeUserProfileEntity(
      userId: doc['userId'] as String,
      photoUrl: doc['photoUrl'] as String? ?? defaultPhotoUrl,
      description: doc['description'] as String? ?? defaultDescription,
      weTag: doc['weTag'] as String,
    );
  }
}
