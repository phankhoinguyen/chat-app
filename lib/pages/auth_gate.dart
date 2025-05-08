import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leo_app/main.dart';
import 'package:leo_app/services/auth/auth_provider.dart';
import 'package:leo_app/pages/home_page.dart';
import 'package:leo_app/pages/login_or_register_page.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    mq = MediaQuery.sizeOf(context);
    final authState = ref.watch(authStateProvider);
    return authState.when(
      data: (user) {
        if (user != null) {
          return const HomePage();
        }
        return const LoginOrRegisterPage();
      },
      error: (e, stackTrace) => Text('Lỗi: $e'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
