import 'package:WeChat/utils/doc_snapshot.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDTO {
  String documentId;
  String name;
  String email;
  String username;
  String photoURL;
  UserDTO({
    required this.documentId,
    required this.name,
    required this.email,
    required this.username,
    required this.photoURL,
  });

  factory UserDTO.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.dataAsMap;
    return UserDTO(
      documentId: doc.id,
      name: data['name'],
      email: data['email'],
      username: data['username'],
      photoURL: data['photoURL'],
    );
  }

  @override
  String toString() => 'UserDTO(email: $email, username: $username)';
}
