import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final _db = FirebaseFirestore.instance;
  //Instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in

  Future<UserCredential> signIn(String email, String pass) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //Sign up
  Future<UserCredential> signUp(
    String email,
    String pass,
    String username,
  ) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      _db.collection('users').doc(user.user!.uid).set({
        'uid': user.user!.uid,
        'imageUrl': '',
        'username': username,
        'email': email,
        'passsword': pass,
      });
      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
