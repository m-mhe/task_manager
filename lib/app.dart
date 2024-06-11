import 'package:flutter/material.dart';
import 'package:task_manager/UI/screens/authentication/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            color: Color(0xff21BF73), foregroundColor: Colors.white),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: Colors.green[700],
          unselectedItemColor: Colors.black87,
        ),
        textTheme: const TextTheme(
            titleLarge: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 28,
                color: Colors.black87),
            bodySmall: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
            titleSmall: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87),
            headlineLarge: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
            headlineMedium: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          headlineSmall: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black54),
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.grey[200],
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[500]),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: BorderSide(color: Colors.grey.shade200)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(color: Colors.white)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff21BF73),
            foregroundColor: Colors.white,
            fixedSize: const Size.fromWidth(double.maxFinite),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xff21BF73),
          foregroundColor: Colors.white,
          shape: CircleBorder(),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
