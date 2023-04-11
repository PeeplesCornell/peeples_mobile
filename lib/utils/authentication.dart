import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peeples/models/UserModel.dart';

class AuthenticationState extends StateNotifier<UserModel?> {
  AuthenticationState() : super(null);

  Future<void> setup() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      state = UserModel(
          displayName: user.displayName,
          email: user.email,
          photoURL: user.photoURL,
          uid: user.uid);
    }
  }

  Future<bool> signInWithGoogle(BuildContext context) async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    FirebaseAuth auth = FirebaseAuth.instance;
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await auth.signInWithCredential(credential);
      final User? user = userCredential.user;
      if (user == null) {
        return false;
      }
      state = UserModel(
          displayName: user.displayName,
          email: user.email,
          photoURL: user.photoURL,
          uid: user.uid);
      Navigator.of(context).pushReplacementNamed('/home');
      return true;
    }
    return false;
  }

  Future<bool> signOutWithGoogle(BuildContext context) async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
    state = null;
    Navigator.of(context).pushReplacementNamed('/');
    return true;
  }
}

final authenticationProvider =
    StateNotifierProvider<AuthenticationState, UserModel?>((ref) {
  return AuthenticationState();
});

final isSignedInProvider = Provider<bool>((ref) {
  var user = ref.watch(authenticationProvider);
  if (user == null) {
    return false;
  }
  return true;
});
