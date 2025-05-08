import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leo_app/services/chat/home_services.dart';
import 'package:leo_app/widgets/chat_page/chat_bubble.dart';

class MessageListPage extends StatefulWidget {
  const MessageListPage({super.key, required this.senderId});
  final String senderId;

  @override
  State<MessageListPage> createState() => _MessageListPageState();
}

class _MessageListPageState extends State<MessageListPage> {
  final chatService = ChatServices();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    // return StreamBuilder(stream: stream, builder: builder);
    return StreamBuilder(
      stream: chatService.getMessage(_auth.currentUser!.uid, widget.senderId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return const Text('Something went wrong!!!');
        }

        final listMess = snapshot.data!.docs;
        return ListView.builder(
          itemCount: listMess.length,
          itemBuilder: (context, index) {
            bool isUser = listMess[index]['senderId'] == _auth.currentUser!.uid;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ChatBubble(
                message: listMess[index]['message'],
                isUser: isUser,
              ),
            );
          },
        );
      },
    );
  }
}
