import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, required this.inputText, required this.onTap});
  final String inputText;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          textAlign: TextAlign.center,
          inputText,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
