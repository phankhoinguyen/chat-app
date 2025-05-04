import 'package:flutter/material.dart';
import 'package:leo_app/pages/login_form.dart';
import 'package:leo_app/pages/register_form.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  void tooglePage() {
    setState(() {
      showLoginForm = !showLoginForm;
    });
  }

  bool showLoginForm = true;
  @override
  Widget build(BuildContext context) {
    if (!showLoginForm) {
      return RegisterForm(switchPage: tooglePage);
    }
    return LoginForm(switchPage: tooglePage);
  }
}
