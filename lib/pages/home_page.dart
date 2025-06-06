import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:leo_app/models/message.dart';
import 'package:leo_app/pages/chat_page.dart';
import 'package:leo_app/services/chat/home_services.dart';
import 'package:leo_app/services/chat/user_provider.dart';
import 'package:leo_app/services/push_notification/notification_service.dart';
import 'package:leo_app/themes/theme_provider.dart';
import 'package:leo_app/widgets/home_page_widgets/drawer_home.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    ref.watch(themeProvider);
    final notiService = NotificationService();
    final chatService = ChatServices();
    final currentUser = FirebaseAuth.instance.currentUser;
    final userStream = chatService.getUser();
    final getUsername = ref.watch(usernameProvider);
    final username = ref.watch(usernameLocalProvider);

    notiService.getToken();
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Messenger')),
      drawer: DrawerHome(
        username: getUsername.when(
          data: (username) {
            return username!;
          },
          error: (err, _) => 'Lỗi rùi',
          loading: () => 'Loading...',
        ),
      ),
      body: StreamBuilder(
        stream: userStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No users found'));
          }
          final users =
              snapshot.data!
                  .where((user) => user['email'] != currentUser!.email)
                  .toList();
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              final chatRoomId = chatService.getChatId(
                currentUser!.uid,
                user['uid'],
              );

              return StreamBuilder(
                stream: chatService.getLastMessage(user, chatRoomId),
                builder: (context, messageSnapshot) {
                  Message? lastMessage;
                  if (messageSnapshot.hasData &&
                      messageSnapshot.data!.docs.isNotEmpty) {
                    final query = messageSnapshot.data!.docs.first;
                    lastMessage = Message(
                      query['senderId'],
                      query['senderUsername'],
                      query['receiverId'],
                      query['message'],
                      query['timestamp'],
                      query['senderImgUrl'],
                      query['type'] == TypeMess.text.name
                          ? TypeMess.text
                          : TypeMess.img,
                    );
                  }
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder:
                              (context) => ChatPage(
                                senderUsername: username,
                                receiverId: user['uid'],
                                username: user['username'],
                                imgUrl: user['imageUrl'],
                              ),
                        ),
                      );
                    },
                    leading:
                        user['imageUrl'] == ''
                            ? CircleAvatar(
                              backgroundColor: Colors.grey.shade400,
                              child: const FaIcon(
                                FontAwesomeIcons.userTie,
                                size: 30,
                              ),
                            )
                            : CircleAvatar(
                              backgroundImage: NetworkImage(user['imageUrl']),
                            ),
                    title: Text(
                      user['username'],
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontFamily: 'Cedora',
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    subtitle:
                        lastMessage == null
                            ? const Text('Chưa có tin nhắn')
                            : lastMessage.type.name == TypeMess.text.name
                            ? Text(
                              lastMessage.message,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 13),
                            )
                            : Text('${user['username']} đã gửi ảnh'),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
