import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leo_app/services/auth/auth_provider.dart';

final avatarImgProvider = FutureProvider<String?>((ref) async {
  final user = ref.watch(authStateProvider).value;
  if (user == null) return null;

  final doc =
      await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

  return doc.data()?['imageUrl'] as String?;
});

final usernameProvider = FutureProvider<String?>((ref) async {
  final user = ref.watch(authStateProvider).value;
  if (user == null) return null;
  print('Provider : ${user.email}');

  final doc =
      await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
  final username = doc.data()?['username'] as String?;
  ref.read(usernameLocalProvider.notifier).state = username!;
  return username;
});

final usernameLocalProvider = StateProvider<String>((ref) {
  return 'Loading...';
});

final isUploadingImg = StateProvider<bool>((ref) {
  return false;
});
