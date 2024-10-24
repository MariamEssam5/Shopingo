import 'package:flutter/material.dart';

class CustomLogoAuth extends StatelessWidget {
  const CustomLogoAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: 200, // Adjust width as needed
        height: 200, // Adjust height as needed
        padding: const EdgeInsets.all(0), // Remove padding
        decoration: BoxDecoration(
          color: Colors.transparent, // Remove border color
        ),
        child: Image.asset(
          "assets/images/3094352-removebg-preview.png",
          height: 200, // Increase image height for larger size
          width: 200, // Adjust width if needed
          fit: BoxFit.cover, // Adjust fit as needed
        ),
      ),
    );
  }
}
