import 'package:flutter/material.dart';
import 'package:khuda_diary/Pages/recipes_screen.dart'; // Replace with your actual home screen import

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const RecipesHomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent, // Splash background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Image
            Image.asset(
              'assets/logo.png', // Replace with your logo file path
              height: 150,
            ),
            const SizedBox(height: 20),
            // App Name
            const Text(
              'Khuda Diary',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2,
                shadows: [
                  Shadow(
                    offset: Offset(2, 2),
                    color: Colors.black,
                    blurRadius: 5,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Tagline
            const Text(
              'Discover Your Next Recipe',
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Color.fromARGB(213, 255, 255, 255),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
