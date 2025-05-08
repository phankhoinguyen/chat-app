import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:leo_app/main.dart';
import 'package:leo_app/widgets/chat_page/message_list_page.dart';
import 'package:leo_app/services/chat/home_services.dart';
import 'package:leo_app/widgets/chat_page/messages_input.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({
    super.key,
    required this.senderUsername,
    required this.username,
    required this.imgUrl,
    required this.receiverId,
  });
  final String username;
  final String imgUrl;
  final String receiverId;
  final String senderUsername;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  void sendMessages() async {
    if (messageInput.text.isNotEmpty) {
      await service.sendMessages(
        widget.senderUsername,
        widget.receiverId,
        messageInput.text,
      );
      messageInput.clear();
    }
  }

  final messageInput = TextEditingController();
  final service = ChatServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          leading:
              widget.imgUrl != ''
                  ? CircleAvatar(backgroundImage: NetworkImage(widget.imgUrl))
                  : CircleAvatar(
                    backgroundColor: Colors.grey.shade400,
                    child: FaIcon(
                      FontAwesomeIcons.userTie,
                      size: 30,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),

          title: Text(
            widget.username,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontFamily: 'Cedora',
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          //Messages List
          Expanded(child: MessageListPage(senderId: widget.receiverId)),
          // Messages Input
          MessagesInput(messageInput: messageInput, ontap: sendMessages),
        ],
      ),
    );
  }
}
