import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 3),
        borderRadius: BorderRadius.circular(10),
      );

  static final darkThemeMode = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppPallete.backgroundColor,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppPallete.backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: AppPallete.whiteColor),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(27),
        enabledBorder: _border(),
        focusedBorder: _border(AppPallete.gradient2),
        errorBorder: _border(Colors.red),
        focusedErrorBorder: _border(AppPallete.gradient2),
        border: _border(),
        outlineBorder:
            const BorderSide(color: AppPallete.borderColor, width: 3),
      ),
      chipTheme: ChipThemeData(
        color: MaterialStateProperty.all(AppPallete.backgroundColor),
        side: BorderSide.none,
      ));
}
