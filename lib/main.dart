// lib/main.dart

// Dart and Flutter core packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:device_preview/device_preview.dart';

// Local imports for screens and models
import 'package:store_app/auth/login.dart';
import 'package:store_app/auth/signup.dart';
import 'package:store_app/screens/Verified%20_Email.dart';
import 'package:store_app/screens/admin_page.dart';
import 'package:store_app/screens/cart_screen.dart';
import 'package:store_app/screens/category_app.dart';
import 'package:store_app/screens/homeees.dart'; // Ensure this filename matches
import 'package:store_app/screens/onboarding_screen.dart';
import 'package:store_app/screens/product_detailed_screen.dart';
import 'package:store_app/screens/profile_screen.dart';
import 'package:store_app/screens/splash_screen.dart';
import 'package:store_app/screens/update_product_page.dart';
import 'cart_provider.dart';
import 'models/product_model.dart';

// Main entry point
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAoGcREMMYU0j7ZGY9eJT38a8lZkAZDC70',
      appId: '1:849992411206:android:40e7eeaf7f004d72b38247',
      messagingSenderId: '849992411206',
      projectId: 'storeeeeeeeeee-1fb10',
    ),
  );

  runApp(DevicePreview(
    builder: (context) => const StoreApp(), // Add the builder parameter here
  ));
}

// StoreApp widget
class StoreApp extends StatefulWidget {
  const StoreApp({super.key});

  @override
  State<StoreApp> createState() => _MyAppState();
}

class _MyAppState extends State<StoreApp> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('===================== User is currently signed out!');
      } else {
        print('===================== User is signed in!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: (FirebaseAuth.instance.currentUser != null &&
                FirebaseAuth.instance.currentUser!.emailVerified)
            ? const HomePage()
            : const SplashScreen(), // Add 'const' here for performance
        routes: {
          "signup": (context) => const SignUp(),
          "login": (context) => const Login(),
          "HomeScreen": (context) => const HomeScreen(),
          "HomeApp": (context) => HomeApp(),
          "AdminPage": (context) =>
              AdminPage(), // Add 'const' here if HomeApp is a stateless widget
          "HomePage": (context) => const HomePage(),
          "onboard_screen": (context) => const OnBoard(),
          // Updated route key for ProfileScreen
          "profile": (context) => const ProfileScreen(),

          ProductDetailsPage.id: (context) => ProductDetailsPage(
                product:
                    ModalRoute.of(context)!.settings.arguments as ProductModel,
              ),
          UpdateProductPage.id: (context) => const UpdateProductPage(),
          CartScreen.id: (context) => const CartScreen(),
        },
      ),
    );
  }
}
