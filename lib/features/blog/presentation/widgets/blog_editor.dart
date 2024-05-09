import 'package:blog_app/core/validators/common_validator.dart';
import 'package:flutter/material.dart';

class BlogEditor extends StatelessWidget with CommonValidator {
  const BlogEditor(
      {super.key, required this.controller, required this.hintText});
  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      maxLines: null,
      validator: (value) => validateEmpty(value, hintText),
    );
  }
}
