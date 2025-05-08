import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message, required this.isUser});
  final String message;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
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
    );
  }
}
