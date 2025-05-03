import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leo_app/auth/auth_gate.dart';
import 'package:leo_app/firebase_options.dart';
import 'package:leo_app/themes/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Đảm bảo các widgets được khởi tạo trước
  await Firebase.initializeApp(
    // Khởi tạo Firebase với cấu hình đã tạo
    options:
        DefaultFirebaseOptions
            .currentPlatform, // Dùng cấu hình Firebase theo từng nền tảng (Android/iOS)
  );
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightMode,
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: AuthGate()),
    );
  }
}
