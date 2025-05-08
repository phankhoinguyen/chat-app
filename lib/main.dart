import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leo_app/pages/auth_gate.dart';
import 'package:leo_app/firebase_options.dart';
import 'package:leo_app/themes/dark_mode.dart';
import 'package:leo_app/themes/light_mode.dart';
import 'package:leo_app/themes/theme_provider.dart';

late Size mq;

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Đảm bảo các widgets được khởi tạo trước

  await Firebase.initializeApp(
    // Khởi tạo Firebase với cấu hình đã tạo
    options:
        DefaultFirebaseOptions
            .currentPlatform, // Dùng cấu hình Firebase theo từng nền tảng (Android/iOS)
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);
    print('Build');
    bool isDark = themeMode == ThemeMode.dark;
    final systemStyle = SystemUiOverlayStyle(
      systemNavigationBarColor:
          isDark ? darkMode.colorScheme.surface : lightMode.colorScheme.surface,
      systemNavigationBarIconBrightness:
          isDark ? Brightness.light : Brightness.dark,
    );
    // isDark
    //     ? SystemChrome.setSystemUIOverlayStyle(
    //       SystemUiOverlayStyle(
    //         systemNavigationBarColor: darkMode.colorScheme.surface,
    //         systemNavigationBarIconBrightness: Brightness.dark,
    //       ),
    //     )
    //     : SystemChrome.setSystemUIOverlayStyle(
    //       SystemUiOverlayStyle(
    //         systemNavigationBarColor: lightMode.colorScheme.surface,
    //         systemNavigationBarIconBrightness: Brightness.light,
    //       ),
    //     );
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemStyle,
      child: MaterialApp(
        themeMode: themeMode,
        theme: lightMode,
        darkTheme: darkMode,
        debugShowCheckedModeBanner: false,
        home: const Scaffold(body: AuthGate()),
      ),
    );
  }
}
