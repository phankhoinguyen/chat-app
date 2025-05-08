import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leo_app/themes/theme_provider.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeProvider) == ThemeMode.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(title: const Text('Settings')),
      body: SwitchListTile(
        value: isDark,
        title: const Text('Dark Mode'),
        onChanged: (value) {
          ref.read(themeProvider.notifier).toggleTheme(value);
        },
      ),
    );
  }
}
