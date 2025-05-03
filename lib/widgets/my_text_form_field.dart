import 'package:flutter/material.dart';

class MyTextFormField extends StatefulWidget {
  const MyTextFormField({
    super.key,
    required this.inputText,
    required this.isPassword,
    required this.controller,
    required this.validator,
  });
  final String inputText;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String? value) validator;

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  bool isHidden = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(color: Theme.of(context).colorScheme.primary),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        decoration: InputDecoration(
          border: InputBorder.none,
          // enabledBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.all(Radius.circular(10)),
          //   borderSide: BorderSide(
          //     color: Theme.of(context).colorScheme.primary,
          //   ),
          // ),
          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.all(Radius.circular(10)),
          //   borderSide: BorderSide(
          //     color: Theme.of(context).colorScheme.secondary,
          //   ),
          //   gapPadding: 4,
          // ),
          fillColor: Theme.of(context).colorScheme.surface,
          filled: true,
          // Làm label hiện như hint khi chưa click
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          label: Text(
            widget.inputText,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          suffixIcon:
              widget.isPassword
                  ? IconButton(
                    icon: Icon(
                      isHidden ? Icons.visibility : Icons.visibility_off,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () {
                      setState(() {
                        isHidden = !isHidden;
                      });
                    },
                  )
                  : null,
        ),
        keyboardType:
            widget.isPassword ? TextInputType.text : TextInputType.emailAddress,
        autocorrect: false,
        textCapitalization: TextCapitalization.none,
        obscureText: widget.isPassword ? isHidden : false,
      ),
    );
  }
}
