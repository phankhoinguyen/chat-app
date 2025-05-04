import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;

// Lấy dữ liệu người dùng

Stream<List<Map<String, dynamic>>> getUser() {
  return _db.collection('Users').snapshots().map((snapshot) {
    return snapshot.docs.map((doc) {
      final user = doc.data();
      return user;
    }).toList();
  });
}
