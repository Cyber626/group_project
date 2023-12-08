import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:group_project/screens/tabs.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 73, 75, 216),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 15, 4, 63),
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
        home: const TabsScreen(),
      ),
    ),
  );
}
