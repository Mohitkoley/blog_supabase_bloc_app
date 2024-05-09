// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:blog_app/core/common/extensions/app_extension.dart';
import 'package:blog_app/core/theme/app_pallete.dart';

class BottomText extends StatelessWidget {
  const BottomText({
    super.key,
    required this.text1,
    required this.text2,
    required this.text1Tap,
    required this.text2Tap,
  });
  final String text1;
  final String text2;
  final VoidCallback text1Tap;
  final VoidCallback text2Tap;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: text1,
            style: context.titleMedium,
            recognizer: TapGestureRecognizer()..onTap = text1Tap,
            children: [
          TextSpan(
              text: text2,
              recognizer: TapGestureRecognizer()..onTap = text2Tap,
              style: context.titleMedium.copyWith(
                  color: AppPallete.gradient2, fontWeight: FontWeight.bold))
        ]));
  }
}
