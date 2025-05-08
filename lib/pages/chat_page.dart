import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  final messageInput = TextEditingController();
  final service = ChatServices();
  FocusNode _focusNode = FocusNode();
  final _scrollController = ScrollController();

  void sendMessages() async {
    if (messageInput.text.isNotEmpty) {
      await service.sendMessages(
        widget.senderUsername,
        widget.receiverId,
        messageInput.text,
      );
      messageInput.clear();
    }
    scrollDown();
  }

  void scrollDown() {
    print(_scrollController.position.maxScrollExtent);
    _scrollController.animateTo(
      _scrollController.position.minScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.easeOut,
    );
  }

  // @override
  // void initState() {
  //   super.initState();

  //   // Future.delayed(const Duration(milliseconds: 500), () => scrollDown());

  //   _focusNode.addListener(() {
  //     // if (_focusNode.hasFocus) {
  //     //   Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
  //     // }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_focusNode.hasFocus) {
          _focusNode.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: ListTile(
            leading:
                widget.imgUrl != ''
                    ? CircleAvatar(backgroundImage: NetworkImage(widget.imgUrl))
                    : CircleAvatar(
                      backgroundColor: Colors.grey.shade400,
                      child: const FaIcon(FontAwesomeIcons.userTie, size: 30),
                    ),

            title: Text(
              widget.username,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontFamily: 'Cedora',
                fontSize: 18.0,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            //Messages List
            Expanded(
              child: MessageListPage(
                senderId: widget.receiverId,
                controller: _scrollController,
              ),
            ),
            // Messages Input
            SafeArea(
              child: MessagesInput(
                messageInput: messageInput,
                ontap: sendMessages,
                focusNode: _focusNode,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
