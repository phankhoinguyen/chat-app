import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leo_app/services/chat/user_provider.dart';

class UserAvatar extends ConsumerStatefulWidget {
  const UserAvatar({super.key});

  @override
  ConsumerState<UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends ConsumerState<UserAvatar> {
  final _db = FirebaseFirestore.instance;

  void pickImg() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return;
    }
    final pickedImg = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    if (pickedImg == null) return;
    final imgFile = File(pickedImg.path);
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('user_images')
        .child('${currentUser.uid}.jpg');
    await storageRef.putFile(imgFile);
    final imgUrl = await storageRef.getDownloadURL();
    await _db.collection('users').doc(currentUser.uid).update({
      'imageUrl': imgUrl,
    });
    ref.invalidate(avatarImgProvider);
  }

  @override
  Widget build(BuildContext context) {
    final avatar = ref.watch(avatarImgProvider);

    return avatar.when(
      data:
          (url) => GestureDetector(
            onTap: pickImg,
            child:
                url != ''
                    ? CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(url!),
                    )
                    : CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      child: FaIcon(
                        FontAwesomeIcons.userTie,
                        size: 30,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
          ),
      loading: () => const CircleAvatar(child: CircularProgressIndicator()),
      error: (e, _) => const CircleAvatar(child: Icon(Icons.error)),
    );
  }
}
