import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:group_project/screens/login.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 8, 143, 78),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 1, 28, 15),
);

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        theme: ThemeData().copyWith(
          colorScheme: kColorScheme,
        ),
        darkTheme: ThemeData.dark().copyWith(
          colorScheme: kDarkColorScheme,
        ),
        home: const LoginScreen(),
      ),
    ),
  );
}
