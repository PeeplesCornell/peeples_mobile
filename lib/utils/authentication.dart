import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peeples/models/UserModel.dart';
import 'package:uuid/uuid.dart';

import '../models/Post.dart';
import '../models/HistoryModel.dart';

class FirebaseState extends StateNotifier<UserModel?> {
  DocumentSnapshot? lastDocumentSnapshot;
  DocumentSnapshot? lastHistorySnapshot;
  FirebaseState() : super(null);

  void resetLastHistory() {
    lastHistorySnapshot = null;
    Future<List<String>> getQuestionnaire() async {
      return Future.delayed(
          const Duration(seconds: 2), () => ["fake data", "fake2", "fake3"]);
    }

  Future<List<Post>> getPosts(int pageKey, int pageSize) async {
    var query = FirebaseFirestore.instance
        .collection('feeds')
        .orderBy('visited_time', descending: true)
        .limit(pageSize);

    if (lastDocumentSnapshot != null) {
      query = query.startAfterDocument(lastDocumentSnapshot!);
    }

    final snapshot = await query.get();
    lastDocumentSnapshot = snapshot.docs.last;
    final posts =
        snapshot.docs.map((doc) => Post.fromFirestore(doc.data())).toList();
    return posts;
  }

  Future<List<HistoryModel>> getHistorys(int pageKey, int pageSize) async {
    // var uid = ref.watch(userIdProvider);
    var uid = FirebaseAuth.instance.currentUser!.uid;
    var query = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('history')
        .orderBy('time', descending: true)
        .limit(pageSize);

    if (lastHistorySnapshot != null) {
      query = query.startAfterDocument(lastHistorySnapshot!);
    }

    final snapshot = await query.get();
    lastHistorySnapshot = snapshot.docs.last;
    final historys = snapshot.docs
        .map((doc) => HistoryModel.fromFirestore(doc.data()))
        .toList();
    return historys;
  }

  Future<void> setup(BuildContext context) async {
  void resetPage() {
    lastDocumentSnapshot = null;
  }

  Future<void> setup() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    // uuid based on device

    FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user != null) {
        var fcmToken = await FirebaseMessaging.instance.getToken();
        var uid = FirebaseAuth.instance.currentUser!.uid;
        // access firebase firestore with given uid and update the fcm token if not exist create a doc
        FirebaseFirestore.instance.collection('users').doc(uid).set({
          'fcm_token': fcmToken,
        }, SetOptions(merge: true));
      }
    });

    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      print("token: $fcmToken");
      if (FirebaseAuth.instance.currentUser == null) {
        return;
      }
      var uid = FirebaseAuth.instance.currentUser!.uid;
      print("uid: $uid");
      FirebaseFirestore.instance.collection('users').doc(uid).update({
        'fcm_token': fcmToken,
      });
    }).onError((err) {
      // Error getting token.
      debugPrint("token error: $err");
    });

    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      state = UserModel(
          displayName: user.displayName,
          email: user.email,
          photoURL: user.photoURL,
          uid: user.uid);
      if (context.mounted) Navigator.of(context).pushReplacementNamed('/home');
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
      if (context.mounted) Navigator.of(context).pushReplacementNamed('/home');
      return true;
    }
    return false;
  }

  Future<bool> signOutWithGoogle(BuildContext context) async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
    state = null;
    if (context.mounted) Navigator.of(context).pushReplacementNamed('/');
    return true;
  }
}

final firebaseProvider =
    StateNotifierProvider<FirebaseState, UserModel?>((ref) {
  return FirebaseState();
});

final isSignedInProvider = Provider<bool>((ref) {
  var user = ref.watch(firebaseProvider);
  if (user == null) {
    return false;
  }
  return true;
});

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final userIdProvider = Provider<String>((ref) {
  var user = ref.watch(firebaseProvider);
  if (user == null) {
    return '';
  } else {
    return user.uid!;
  }
});
