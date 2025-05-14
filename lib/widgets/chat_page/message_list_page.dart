import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leo_app/services/chat/home_services.dart';
import 'package:leo_app/widgets/chat_page/chat_bubble.dart';

class MessageListPage extends StatefulWidget {
  const MessageListPage({
    super.key,
    required this.senderId,
    required this.controller,
  });
  final String senderId;
  final ScrollController controller;

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
          reverse: true,
          controller: widget.controller,
          itemCount: listMess.length,
          itemBuilder: (context, index) {
            print('Check auth :  ${_auth.currentUser}');
            bool isUser = listMess[index]['senderId'] == _auth.currentUser!.uid;
            // final nextMess =
            //     index + 1 < listMess.length ? listMess[index + 1] : null;
            // final nextMessSenderId =
            //     nextMess != null ? nextMess['senderId'] : null;
            // final isTheSameUser =
            //     nextMessSenderId == listMess[index]['senderId'];
            final prevMess = index - 1 >= 0 ? listMess[index - 1] : null;
            final prevSenderId = prevMess != null ? prevMess['senderId'] : null;
            final isSameUserAsPrev =
                prevSenderId == listMess[index]['senderId'];

            return !isSameUserAsPrev && !isUser
                ? ChatBubble.first(
                  type: listMess[index]['type'],
                  message: listMess[index]['message'],
                  isUser: isUser,
                  imgUrl: listMess[index]['senderImgUrl'],
                )
                : ChatBubble.next(
                  type: listMess[index]['type'],
                  message: listMess[index]['message'],
                  isUser: isUser,
                );
          },
        );
      },
    );
  }
}
