import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:leo_app/services/auth/auth_services.dart';
import 'package:leo_app/widgets/login_page_widgets/auth_button.dart';
import 'package:leo_app/widgets/login_page_widgets/my_text_form_field.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key, required this.switchPage});
  final void Function() switchPage;

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  String? _eMessage;
  final _auth = AuthServices();
  void logIn() async {
    try {
      if (_formKey.currentState!.validate()) {
        await _auth.signIn(_email.text, _password.text);
      }
    } catch (e) {
      setState(() {
        _eMessage = 'Đăng nhập không thành công: ${e.toString()}';
      });
    }
  }

  final _email = TextEditingController();
  final _password = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FaIcon(FontAwesomeIcons.waze, size: 60),
            const SizedBox(height: 50),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    if (_eMessage != null)
                      Text(
                        _eMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    MyTextFormField(
                      inputText: 'Số di động hoặc email',
                      isPassword: false,
                      controller: _email,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Vui lòng nhập gmail';
                        }
                        final gmailRegex = RegExp(r'^[\w]+@gmail\.com$');
                        if (!gmailRegex.hasMatch(value)) {
                          return 'Email phải là địa chỉ Gmail hợp lệ';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    MyTextFormField(
                      inputText: 'Mật khẩu',
                      isPassword: true,
                      controller: _password,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Vui lòng nhập mật khẩu';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    AuthButton(inputText: 'Đăng nhập', onTap: logIn),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Chưa có tài khoản sao?',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 3),
                        GestureDetector(
                          onTap: widget.switchPage,
                          child: Text(
                            'Đăng ký liền tay',
                            style: Theme.of(
                              context,
                            ).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
