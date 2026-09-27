import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() => runApp(const MovieWatchlistApp());

class MovieWatchlistApp extends StatelessWidget {
  const MovieWatchlistApp({super.key});

  static const ink = Color(0xFF17130F);
  static const paper = Color(0xFFF4EEDF);
  static const rust = Color(0xFFB4472D);
  static const olive = Color(0xFF59633A);

  @override
  Widget build(BuildContext context) {
    final colors = ColorScheme.fromSeed(
      seedColor: rust,
      brightness: Brightness.light,
      primary: rust,
      secondary: olive,
      surface: const Color(0xFFFFFBF2),
      onSurface: ink,
    );
    return MaterialApp(
      title: 'Reel Archive',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colors,
        scaffoldBackgroundColor: paper,
        fontFamily: 'serif',
        appBarTheme: const AppBarTheme(
          backgroundColor: paper,
          foregroundColor: ink,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          color: colors.surface,
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color(0xFFD8CEBB)),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: ink,
          contentTextStyle: TextStyle(color: paper),
          behavior: SnackBarBehavior.floating,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
