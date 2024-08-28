import 'dart:convert';

import 'package:equatable/equatable.dart';

class WeUserFriends extends Equatable {
  final String userId;
  final List<String> userFriends;
  const WeUserFriends({
    required this.userId,
    required this.userFriends,
  });
  @override
  List<Object> get props => <Object>[userId, userFriends];

  WeUserFriends copyWith({
    String? userId,
    List<String>? userFriends,
  }) {
    return WeUserFriends(
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

  factory WeUserFriends.fromMap(Map<String, dynamic> map) {
    return WeUserFriends(
      userId: map['userId'] as String,
      userFriends: List<String>.from((map['userFriends'] as List<String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory WeUserFriends.fromJson(String source) =>
      WeUserFriends.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
