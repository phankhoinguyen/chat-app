import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:leo_app/main.dart';

class MessagesInput extends StatefulWidget {
  const MessagesInput({
    super.key,
    required this.messageInput,
    required this.sendTextMessages,
    required this.focusNode,
    required this.sendImgMessages,
    required this.sendMultiImgMessages,
  });
  final TextEditingController messageInput;
  final void Function() sendTextMessages;
  final void Function() sendImgMessages;
  final void Function() sendMultiImgMessages;
  final FocusNode focusNode;
  @override
  State<MessagesInput> createState() => _MessagesInputState();
}

class _MessagesInputState extends State<MessagesInput> {
  var isShowEmoji = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 8, 8, mq.height * .01),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            widget.focusNode.unfocus();
                            isShowEmoji = !isShowEmoji;
                          });
                        },
                        icon: const Icon(Icons.emoji_emotions),
                      ),
                      Expanded(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 150),
                          child: TextField(
                            onTap: () {
                              setState(() {
                                isShowEmoji = false;
                              });
                            },
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
                        onPressed: widget.sendImgMessages,
                        icon: const Icon(Icons.camera_alt_rounded, size: 25),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: widget.sendMultiImgMessages,
                        icon: const FaIcon(
                          FontAwesomeIcons.solidImage,
                          size: 23,
                        ),
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
                            ? widget.sendTextMessages
                            : null,
                    color: Theme.of(context).colorScheme.secondary,
                    icon: const Icon(Icons.send),
                  );
                },
              ),
            ],
          ),
          Offstage(
            offstage: !isShowEmoji,
            child: EmojiPicker(
              textEditingController:
                  widget
                      .messageInput, // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
              config: Config(
                height: 300,
                checkPlatformCompatibility: true,
                emojiViewConfig: EmojiViewConfig(
                  columns: 7,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  emojiSizeMax:
                      28 *
                      (foundation.defaultTargetPlatform == TargetPlatform.iOS
                          ? 1.20
                          : 1.0),
                ),
                viewOrderConfig: const ViewOrderConfig(
                  bottom: EmojiPickerItem.categoryBar,
                  middle: EmojiPickerItem.emojiView,
                  top: EmojiPickerItem.searchBar,
                ),
                categoryViewConfig: const CategoryViewConfig(
                  initCategory: Category.SMILEYS,
                ),
                bottomActionBarConfig: BottomActionBarConfig(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  buttonIconColor: Colors.black,
                  buttonColor: Theme.of(context).colorScheme.surface,
                ),
                searchViewConfig: const SearchViewConfig(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
