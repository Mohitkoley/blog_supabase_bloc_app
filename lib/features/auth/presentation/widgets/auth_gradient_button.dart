import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {
  const AuthGradientButton(
      {super.key, required this.onPressed, required this.text});
  final VoidCallback onPressed;
  final String text;

  BorderRadiusGeometry get _borderRadius => BorderRadius.circular(7);

  double get _buttonHeight => 50;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: _buttonHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppPallete.gradient1, AppPallete.gradient2],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
          borderRadius: _borderRadius,
        ),
        child: MaterialButton(
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: _borderRadius,
          ),
          minWidth: double.infinity,
          height: _buttonHeight,
          child: Text(
            text,
            style: const TextStyle(
                color: AppPallete.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ));
  }
}
