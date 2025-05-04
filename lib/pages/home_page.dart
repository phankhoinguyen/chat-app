import 'package:flutter/material.dart';
import 'package:leo_app/widgets/home_page_widgets/drawer_home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Messenger')),
      drawer: const DrawerHome(userName: 'Khôi Nguyên', profileImage: null),
    );
  }
}
