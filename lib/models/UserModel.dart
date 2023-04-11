import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String? displayName;
  final String? email;
  final String? photoURL;
  final String? uid;

  UserModel({
    required this.displayName,
    required this.email,
    required this.photoURL,
    required this.uid,
  });
}
