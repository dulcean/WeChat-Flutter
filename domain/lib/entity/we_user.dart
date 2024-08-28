import 'dart:convert';

import 'package:equatable/equatable.dart';

class WeUser extends Equatable {
  final String userId;
  final String email;
  final String name;
  const WeUser({
    required this.userId,
    required this.email,
    required this.name,
  });

  @override
  List<Object> get props => <String>[userId, email, name];

  WeUser copyWith({
    String? userId,
    String? email,
    String? name,
  }) {
    return WeUser(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'email': email,
      'name': name,
    };
  }

  factory WeUser.fromMap(Map<String, dynamic> map) {
    return WeUser(
      userId: map['userId'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeUser.fromJson(String source) =>
      WeUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
