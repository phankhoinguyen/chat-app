import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:leo_app/main.dart';

class MessagesInput extends StatefulWidget {
  const MessagesInput({
    super.key,
    required this.messageInput,
    required this.ontap,
    required this.focusNode,
  });
  final TextEditingController messageInput;
  final void Function() ontap;
  final FocusNode focusNode;
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
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.emoji_emotions),
                  ),
                  Expanded(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 150),
                      child: TextField(
                        focusNode: widget.focusNode,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: widget.messageInput,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Tin nhắn',
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    icon: const Icon(Icons.camera_alt_rounded, size: 25),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    icon: const FaIcon(FontAwesomeIcons.solidImage, size: 23),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 5),
          ValueListenableBuilder(
            valueListenable: widget.messageInput,
            builder: (context, value, child) {
              return IconButton(
                onPressed:
                    widget.messageInput.text.trim().isNotEmpty
                        ? widget.ontap
                        : null,
                color: Theme.of(context).colorScheme.secondary,
                icon: const Icon(Icons.send),
              );
            },
          ),
        ],
      ),
    );
  }
}
