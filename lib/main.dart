import 'package:flashcard_forge_app/screens/about_screen.dart';
import 'package:flashcard_forge_app/screens/flashcards_screen.dart';
import 'package:flashcard_forge_app/screens/home_screen.dart';
import 'package:flashcard_forge_app/screens/study_history_screen.dart';
import 'package:flashcard_forge_app/utils/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcard Forge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Comfortaa",
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(224, 244, 255, 1)),
        useMaterial3: true,
        scaffoldBackgroundColor: Styles.primaryColor,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        )
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(title: "Flashcard Forge"),
        '/flashcards': (context) => const FlashcardScreen(),
        '/history': (context) => const StudyHistoryScreen(),
        '/about': (context) => const AboutScreen()
      },
    );
  }
}