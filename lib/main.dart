import 'package:flashcard_forge_app/providers.dart';
import 'package:flashcard_forge_app/screens/about_screen.dart';
import 'package:flashcard_forge_app/screens/flashcards_screen.dart';
import 'package:flashcard_forge_app/screens/home_screen.dart';
import 'package:flashcard_forge_app/screens/study_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
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
          theme: themeProvider.currentTheme,
          initialRoute: '/',
          routes: {
            '/': (context) => const HomeScreen(),
            '/flashcards': (context) => const FlashcardScreen(),
            '/history': (context) => const StudyHistoryScreen(),
            '/about': (context) => const AboutScreen()
          },
        );
      },
    );
  }
}
