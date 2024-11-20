import 'package:flutter/material.dart';

class StorageKeys {
  static const String userData = 'user_data';
  static const String subjects = 'subjects';
  static const String preferences = 'preferences';
  static const String studySessionHistory = 'study_session_history';
}


class Styles {
  static const Color secondaryColor = Color.fromARGB(255, 17, 16, 16);
  static const Color primaryColor = Colors.black;
  static const Color accentColor = Color.fromARGB(255, 16, 130, 156);
  static const Color greenEasy = Colors.green;
  static const Color redHard = Colors.red;
  static const Color blueNeutral = Colors.blue;
  static const Color yellowReasonable = Colors.yellowAccent;
  static const Color backgroundText = Color.fromARGB(255, 54, 54, 54);

  static const LinearGradient linearGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromARGB(255, 26, 25, 25),
      secondaryColor,
    ],
  );
}


class CustomTheme {
  final LinearGradient linearGradient;
  final ThemeData themeData;

  CustomTheme({
    required this.linearGradient,
    required this.themeData,
  });
}

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    fontFamily: "Comfortaa",
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFFFF3E3),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.grey[200],
    ),
    scaffoldBackgroundColor: const Color(0xFFFFF3E3),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.black),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      brightness: Brightness.light,
      primary: const Color(0xFFFFF3E3),
      secondary: Styles.accentColor,
    ),
    hintColor: const Color.fromARGB(135, 0, 0, 0),
    popupMenuTheme: PopupMenuThemeData(
      color: Colors.grey[200],
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Colors.grey[200],
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    fontFamily: "Comfortaa",
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color.fromARGB(255, 17, 17, 17)
    ),
    scaffoldBackgroundColor: Styles.primaryColor,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.white),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      brightness: Brightness.dark,
      primary: Styles.primaryColor,
      secondary: Styles.accentColor
    ),
    popupMenuTheme: const PopupMenuThemeData(
      color: Color.fromARGB(255, 17, 16, 16)
    ), 
    dialogTheme: const DialogTheme(
      backgroundColor: Color.fromARGB(255, 17, 17, 17)
    )
  );

  static final ThemeData beigeTheme = ThemeData(
    fontFamily: "Comfortaa",
    scaffoldBackgroundColor: const Color(0xFFF5F5DC), // Beige background
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.brown),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      brightness: Brightness.light,
      primary: const Color(0xFFF5F5DC), // Beige
      secondary: const Color(0xFFD2B48C) // Tan
    ),
  );

  static final ThemeData pinkTheme = ThemeData(
    fontFamily: "Comfortaa",
    scaffoldBackgroundColor: const Color(0xFFFFE4E1), // Misty Rose background
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.pink),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      brightness: Brightness.light,
      primary: const Color(0xFFFFC0CB), // Pink
      secondary: const Color(0xFFFF69B4), // Hot Pink
    ),
  );

  static final ThemeData purpleTheme = ThemeData(
    fontFamily: "Comfortaa",
    scaffoldBackgroundColor: const Color(0xFFE6E6FA), // Lavender background
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.purple),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      brightness: Brightness.light,
      primary: const Color(0xFF800080), // Purple
      secondary: const Color(0xFF9370DB), // Medium Purple
    ),
  );

  static final ThemeData lightBlueTheme = ThemeData(
    fontFamily: "Comfortaa",
    scaffoldBackgroundColor: const Color(0xFFE0FFFF), // Light Cyan background
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.blue),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      brightness: Brightness.light,
      primary: const Color(0xFFADD8E6), // Light Blue
      secondary: const Color(0xFF87CEEB) // Sky Blue
    ),
  );
}

