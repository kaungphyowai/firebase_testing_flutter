import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class API {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  Stream<User> streamingAuthState(BuildContext context) {
    return _auth.authStateChanges();
  }

  Stream<QuerySnapshot> streamNews() {
    return _db.collection("news").snapshots();
  }

  Future<void> signInanony() {
    _auth.signInAnonymously();
  }

  Future<void> signOut() {
    _auth.signOut();
  }
}
