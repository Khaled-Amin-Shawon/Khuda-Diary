import 'package:flutter/material.dart';
import 'package:khuda_diary/Pages/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false, // Hide Flutter's debug mode banner
          title: 'Khuda Diary',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: currentMode, // Use current theme mode
          home: const SplashScreen(),
        );
      },
    );
  }
}

// Theme state
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);
