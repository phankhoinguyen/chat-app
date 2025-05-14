import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:leo_app/models/message.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble.first({
    super.key,
    required this.message,
    required this.isUser,
    required this.imgUrl,
    required this.type,
  }) : isFirstInSequence = true;
  const ChatBubble.next({
    super.key,
    required this.message,
    required this.isUser,
    required this.type,
  }) : isFirstInSequence = true,
       imgUrl = null;

  final String message;
  final bool isUser;

  final String? imgUrl;
  final bool isFirstInSequence;
  final String type;

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
                  padding:
                      type == TypeMess.text.name
                          ? const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          )
                          : null,
                  constraints:
                      type == TypeMess.text.name
                          ? BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.65,
                          )
                          : const BoxConstraints(maxWidth: 300),
                  margin: const EdgeInsets.only(bottom: 10),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color:
                        isUser
                            ? Theme.of(context).colorScheme.secondary
                            : Colors.grey.shade400,
                  ),
                  child:
                      type == TypeMess.text.name
                          ? Text(
                            message,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyLarge!.copyWith(
                              color: isUser ? Colors.white : Colors.black,
                            ),
                          )
                          : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              imageUrl: message,
                              fit: BoxFit.cover,
                              placeholder:
                                  (context, url) => const SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                              errorWidget:
                                  (context, url, error) =>
                                      const Icon(Icons.error),
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
