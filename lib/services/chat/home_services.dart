import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:leo_app/models/message.dart';

class ChatServices {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  // Lấy dữ liệu người dùng
  Stream<List<Map<String, dynamic>>> getUser() {
    return _db.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  //Gửi tin nhắn
  Future<void> sendMessages(String senderUsername, receiverId, messages) async {
    final user =
        await _db.collection('users').doc(_auth.currentUser!.uid).get();
    Message newMessage = Message(
      _auth.currentUser!.uid,
      senderUsername,
      receiverId,
      messages,
      Timestamp.now(),
      user.data()!['imageUrl'],
    );

    // Tạo chat room id
    List<String> ids = [_auth.currentUser!.uid, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    await _db
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('message')
        .add(newMessage.toMap());
  }

  // Lấy dữ liệu tin nhắn
  Stream<QuerySnapshot> getMessage(String userId, String senderId) {
    List<String> ids = [userId, senderId];
    ids.sort();
    String chatRoomId = ids.join('_');

    return _db
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('message')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
