import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app_2/screens/home.dart';
import 'package:todo_app_2/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.showHome});
  final bool showHome;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    delay();
  }

  Future<void> delay() async {
    await Future.delayed(const Duration(seconds: 6));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            widget.showHome ? const HomeScreen() : const OnboardingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Center(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.7,
          child: Lottie.asset(
            'lib/assets/animations/splash_screen_animation.json',
          ),
        ),
      ),
    );
  }
}
