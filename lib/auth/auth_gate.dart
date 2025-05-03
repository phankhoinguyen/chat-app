import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leo_app/auth/auth_provider.dart';
import 'package:leo_app/pages/home_page.dart';
import 'package:leo_app/pages/login_page.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    return authState.when(
      data: (user) {
        if (user != null) {
          return const HomePage();
        }
        return const LoginPage();
      },
      error: (e, stackTrace) => Text('Lỗi: $e'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
