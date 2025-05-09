import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final _db = FirebaseFirestore.instance;
  final _currentUser = FirebaseAuth.instance.currentUser;
  final fMessaging = FirebaseMessaging.instance;
  Future<void> getToken() async {
    await fMessaging.requestPermission();
    final userToken = await fMessaging.getToken();
    print(userToken);
    if (userToken != null) {
      await _db.collection('users').doc(_currentUser!.uid).update({
        'token': userToken,
      });
    }
  }
}
