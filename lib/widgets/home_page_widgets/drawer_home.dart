import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leo_app/services/auth/auth_services.dart';
import 'package:leo_app/pages/setting_page.dart';
import 'package:leo_app/services/chat/user_provider.dart';
import 'package:leo_app/widgets/home_page_widgets/user_avatar.dart';

class DrawerHome extends ConsumerWidget {
  const DrawerHome({super.key, required this.username});
  final String username;

  void logOut() {
    final _auth = AuthServices();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const UserAvatar(),
                      const SizedBox(height: 10),
                      Text(
                        username!,
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium!.copyWith(
                          fontFamily: 'Cedora',
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: ListTile(
                  leading: const Icon(Icons.home, size: 26),
                  title: Text(
                    'H O M E',
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.copyWith(fontFamily: 'Cedora'),
                  ),
                  onTap: () => Navigator.of(context).pop(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: ListTile(
                  leading: const Icon(Icons.settings, size: 26),
                  title: Text(
                    'S E T T I N G S',
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.copyWith(fontFamily: 'Cedora'),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SettingPage(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 25),
            child: ListTile(
              leading: const Icon(Icons.logout, size: 26),
              title: Text(
                'L O G  O U T',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(fontFamily: 'Cedora'),
              ),
              onTap: logOut,
            ),
          ),
        ],
      ),
    );
  }
}
