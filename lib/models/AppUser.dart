import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  String? id;
  String? username;
  String? email;
  String? photoUrl;
  String? displayName;
  String? bio;

  AppUser({
    this.id,
    this.username,
    this.email,
    this.photoUrl,
    this.displayName,
    this.bio,
  });

  factory AppUser.fromDocument(DocumentSnapshot doc) {
    return AppUser(
      id: doc['id'],
      email: doc['email'],
      username: doc['username'],
      displayName: doc['displayName'],
      bio: doc['bio'],
    );
  }
}
