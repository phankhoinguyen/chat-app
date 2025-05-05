import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:leo_app/services/auth/auth_services.dart';
import 'package:leo_app/widgets/login_page_widgets/auth_button.dart';
import 'package:leo_app/widgets/login_page_widgets/my_text_form_field.dart';

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({super.key, required this.switchPage});
  final void Function() switchPage;

  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  final _auth = AuthServices();
  String? _eMessage;
  void signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.signUp(_email.text, _password.text, _username.text);
      } catch (e) {
        setState(() {
          _eMessage = 'Đăng ký không thành công, hãy thử lại sau! $e';
        });
      }
    }
  }

  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 70),
              const FaIcon(FontAwesomeIcons.waze, size: 60),
              const SizedBox(height: 50),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: Column(
                    children: [
                      if (_eMessage != null) Text(_eMessage!),
                      MyTextFormField(
                        inputText: 'Tên tài khoản',
                        isPassword: false,
                        controller: _username,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Vui lòng nhập tên tài khoản';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
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
                      const SizedBox(height: 8),
                      MyTextFormField(
                        inputText: 'Nhập lại mật khẩu',
                        isPassword: true,
                        controller: _confirmPassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Vui lòng xác nhận mật khẩu';
                          }
                          if (value != _password.text) {
                            return 'Vui lòng nhập đúng mật khẩu';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      AuthButton(inputText: 'Đăng ký', onTap: signUp),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Đã có tài khoản?',
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
                              'Đăng nhập tài khoản',
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
      ),
    );
  }
}
