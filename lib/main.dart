import 'package:flashcard_forge_app/providers.dart';
import 'package:flashcard_forge_app/screens/about_screen.dart';
import 'package:flashcard_forge_app/screens/flashcards_screen.dart';
import 'package:flashcard_forge_app/screens/home_screen.dart';
import 'package:flashcard_forge_app/screens/study_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Flashcard Forge',
          debugShowCheckedModeBanner: false,
          theme: themeProvider.currentTheme, // Certifique-se de que está usando o tema atual
          initialRoute: '/',
          routes: {
            '/': (context) => const HomeScreen(title: "Flashcard Forge"),
            '/flashcards': (context) => const FlashcardScreen(),
            '/history': (context) => const StudyHistoryScreen(),
            '/about': (context) => const AboutScreen()
          },
        );
      },
    );
  }
}
