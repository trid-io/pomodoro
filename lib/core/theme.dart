import 'package:flutter/material.dart';

ThemeData lightTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light, seedColor: Colors.red),
    useMaterial3: true,
  );
}

ThemeData darkTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark, seedColor: Colors.red),
    useMaterial3: true,
  );
}
