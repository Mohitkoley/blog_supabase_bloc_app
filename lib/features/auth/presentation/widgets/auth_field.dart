import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  const AuthField(
      {super.key,
      required this.hintText,
      required this.validator,
      this.obscureText = false,
      required this.controller});
  final String hintText;
  final String? Function(String?) validator;
  final TextEditingController controller;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
        ));
  }
}
