import 'package:flutter/material.dart';
import 'package:leo_app/widgets/login_form.dart';
import 'package:leo_app/widgets/register_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
