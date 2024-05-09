import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

extension ContextExt on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;
  double get height => MediaQuery.sizeOf(this).height;

  void showSnack(String messages) => ScaffoldMessenger.of(this)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text(
        messages,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: AppPallete.gradient2,
    ));

  TextStyle get titleMedium => Theme.of(this).textTheme.titleMedium!;
}

extension SizedBoxExt on num {
  SizedBox get hBox => SizedBox(height: toDouble());
  SizedBox get wBox => SizedBox(width: toDouble());
  SizedBox get hwBox => SizedBox(width: toDouble(), height: toDouble());
}
