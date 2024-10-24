import 'package:flutter/material.dart';
import 'package:store_app/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return OnBoard();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/images/130804-ORS4U4-585-removebg-preview.png',
                width: 700.0,
                height: 700.0,
              ),
            ),
            const SizedBox(height: 55),
            const Text(
              'Welcome To Our Store App',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
