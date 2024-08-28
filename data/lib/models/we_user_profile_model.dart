import 'dart:convert';

import 'package:equatable/equatable.dart';

class WeUserProfileModel extends Equatable {
  final String userId;
  final String photoUrl;
  final String description;
  final String weTag;
  const WeUserProfileModel({
    required this.userId,
    required this.photoUrl,
    this.description = '',
    required this.weTag,
  });
  @override
  List<Object> get props => [userId, photoUrl, description, weTag];

  WeUserProfileModel copyWith({
    String? userId,
    String? photoUrl,
    String? description,
    String? weTag,
  }) {
    return WeUserProfileModel(
      userId: userId ?? this.userId,
      photoUrl: photoUrl ?? this.photoUrl,
      description: description ?? this.description,
      weTag: weTag ?? this.weTag,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'photoUrl': photoUrl,
      'description': description,
      'weTag': weTag,
    };
  }

  factory WeUserProfileModel.fromMap(Map<String, dynamic> map) {
    return WeUserProfileModel(
      userId: map['userId'] as String,
      photoUrl: map['photoUrl'] as String,
      description: map['description'] as String,
      weTag: map['weTag'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeUserProfileModel.fromJson(String source) => WeUserProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
