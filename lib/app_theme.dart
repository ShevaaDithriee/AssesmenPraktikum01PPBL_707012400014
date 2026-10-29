import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color _warnaBenih = Colors.green;

  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: _warnaBenih,
      brightness: Brightness.light,
    ),
    useMaterial3: true,
  );

  static final ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: _warnaBenih,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  );
}