import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static String id = "ProfileScreen";

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    String username = user != null && user.email != null
        ? user.email!.split('@')[0]
        : "No Name";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.cyan.shade600,
      ),
      body: Center(
        child: user != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Name: $username',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Email: ${user.email}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              )
            : const Text(
                'No user logged in',
                style: TextStyle(fontSize: 20),
              ),
      ),
    );
  }
}
