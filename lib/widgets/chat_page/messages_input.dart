import 'package:flutter/material.dart';
import 'package:leo_app/main.dart';

class MessagesInput extends StatefulWidget {
  const MessagesInput({
    super.key,
    required this.messageInput,
    required this.ontap,
  });
  final TextEditingController messageInput;
  final void Function() ontap;
  @override
  State<MessagesInput> createState() => _MessagesInputState();
}

class _MessagesInputState extends State<MessagesInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 8, 8, mq.height * .01),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: widget.messageInput,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color:
                        Theme.of(
                          context,
                        ).colorScheme.surface, // màu viền thường
                  ),
                ),

                // Viền khi focus vào
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color:
                        Theme.of(
                          context,
                        ).colorScheme.surface, // màu viền khi focus
                    width: 2,
                  ),
                ),
                hintText: 'Tin nhắn',
                fillColor: Theme.of(
                  context,
                ).colorScheme.surface.withValues(alpha: 1.1),
                filled: true,
              ),
            ),
          ),
          const SizedBox(width: 5),
          IconButton(
            onPressed: widget.ontap,
            color: Theme.of(context).colorScheme.secondary,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
