import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  const Message(
    this.senderId,
    this.senderUsername,
    this.receiverId,
    this.message,
    this.timestamp,
  );

  final String senderId;
  final String senderUsername;
  final String receiverId;
  final String message;
  final Timestamp timestamp;

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderUsername': senderUsername,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
