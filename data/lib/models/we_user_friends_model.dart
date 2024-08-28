import 'dart:convert';

import 'package:equatable/equatable.dart';

class WeUserFriendsModel extends Equatable {
  final String userId;
  final List<String> userFriends;
  const WeUserFriendsModel({
    required this.userId,
    required this.userFriends,
  });
  @override
  List<Object> get props => [userId, userFriends];

  WeUserFriendsModel copyWith({
    String? userId,
    List<String>? userFriends,
  }) {
    return WeUserFriendsModel(
      userId: userId ?? this.userId,
      userFriends: userFriends ?? this.userFriends,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'userFriends': userFriends,
    };
  }

  factory WeUserFriendsModel.fromMap(Map<String, dynamic> map) {
    return WeUserFriendsModel(
      userId: map['userId'] as String,
      userFriends: List<String>.from((map['userFriends'] as List<String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory WeUserFriendsModel.fromJson(String source) =>
      WeUserFriendsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
