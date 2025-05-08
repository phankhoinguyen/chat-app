import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble.first({
    super.key,
    required this.message,
    required this.isUser,
    required this.imgUrl,
  }) : isFirstInSequence = true;
  const ChatBubble.next({
    super.key,
    required this.message,
    required this.isUser,
  }) : isFirstInSequence = true,
       imgUrl = null;

  final String message;
  final bool isUser;

  final String? imgUrl;
  final bool isFirstInSequence;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (imgUrl != null)
          Positioned(
            left: 5,
            top: 0,
            right: isUser ? 0 : null,
            child:
                imgUrl != ''
                    ? CircleAvatar(
                      backgroundImage: NetworkImage(imgUrl!),
                      radius: 18,
                    )
                    : CircleAvatar(
                      backgroundColor: Colors.grey.shade400,
                      child: const FaIcon(FontAwesomeIcons.userTie),
                      radius: 18,
                    ),
          ),
        Align(
          alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin:
                !isUser
                    ? const EdgeInsets.symmetric(horizontal: 46)
                    : const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.65,
                  ),
                  margin: const EdgeInsets.only(bottom: 10),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color:
                        isUser
                            ? Theme.of(context).colorScheme.secondary
                            : Colors.grey.shade400,
                  ),
                  child: Text(
                    message,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: isUser ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
