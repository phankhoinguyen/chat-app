import 'package:flutter/material.dart';
import 'package:leo_app/auth/auth_services.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  void logOut() {
    final _auth = AuthServices();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [IconButton(onPressed: logOut, icon: Icon(Icons.logout))],
      ),
    );
  }
}
