import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  const Message(
    this.senderId,
    this.senderUsername,
    this.receiverId,
    this.message,
    this.timestamp,
    this.senderImgUrl,
    this.type,
  );
  final String senderImgUrl;
  final String senderId;
  final String senderUsername;
  final String receiverId;
  final String message;
  final Timestamp timestamp;
  final TypeMess type;

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderUsername': senderUsername,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
      'senderImgUrl': senderImgUrl,
      'type': type.name,
    };
  }
}

enum TypeMess { text, img }
