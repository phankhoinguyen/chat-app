import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:leo_app/services/chat/chat_services.dart';
import 'package:leo_app/services/chat/user_provider.dart';
import 'package:leo_app/widgets/home_page_widgets/drawer_home.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final chatService = ChatServices();
    final currentUser = FirebaseAuth.instance.currentUser;
    final userStream = chatService.getUser();
    final getUsername = ref.watch(usernameProvider);

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Messenger')),
      drawer: DrawerHome(
        username: getUsername.when(
          data: (username) => username!,
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
            return const CircularProgressIndicator();
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No users found'));
          }
          final users =
              snapshot.data!
                  .where((user) => user['email'] != currentUser!.email)
                  .toList();

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                onTap: () {},
                leading:
                    user['imageUrl'] == ''
                        ? CircleAvatar(
                          backgroundColor: Colors.grey.shade400,
                          child: FaIcon(
                            FontAwesomeIcons.userTie,
                            size: 30,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )
                        : CircleAvatar(
                          backgroundImage: NetworkImage(user['imageUrl']),
                        ),
                title: Text(user['username']),
              );
            },
          );
        },
      ),
    );
  }
}
