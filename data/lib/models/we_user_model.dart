import 'dart:convert';

import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

class WeUserModel extends Equatable {
  final String userId;
  final String email;
  final String name;
  const WeUserModel({
    required this.userId,
    required this.email,
    required this.name,
  });

  @override
  List<Object> get props => [userId, email, name];

  WeUserModel copyWith({
    String? userId,
    String? email,
    String? name,
  }) {
    return WeUserModel(
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

  factory WeUserModel.fromMap(Map<String, dynamic> map) {
    return WeUserModel(
      userId: map['userId'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeUserModel.fromJson(String source) =>
      WeUserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  WeUser toEntity(WeUserModel weUserModel) {
    return WeUser(
        userId: weUserModel.userId,
        email: weUserModel.email,
        name: weUserModel.name);
  }

  factory WeUserModel.fromEntity(WeUser weUser) {
    return WeUserModel(
        userId: weUser.userId,
        email: weUser.email,
        name: weUser.name);
  }

  factory WeUserModel.empty() {
    return WeUserModel(userId: '', email: '', name: '');
  }
}
