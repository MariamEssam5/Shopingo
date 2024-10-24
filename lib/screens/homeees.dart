import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:store_app/cart_provider.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/screens/cart_screen.dart';
import 'package:store_app/screens/category_app.dart';
import 'package:store_app/screens/profile_screen.dart'; // Import ProfileScreen
import 'package:store_app/services/get_all_product_service.dart';
import 'package:store_app/widgets/custom_card.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static String id = "HomeScreen";

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser; // Get current user

    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              // Icon button to navigate to HomeApp page
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, HomeApp.id);
                },
                icon: Icon(
                  Icons.category,
                  color: Colors.cyan.shade600,
                ),
              ),
              // Icon button to navigate to CartScreen page
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, CartScreen.id);
                },
                icon: Stack(
                  children: [
                    Icon(
                      FontAwesomeIcons.cartPlus,
                      color: Colors.cyan.shade600,
                    ),
                    Positioned(
                      right: 0,
                      child: Consumer<CartProvider>(
                          builder: (context, cartProvider, child) {
                        return cartProvider.cartItems.isNotEmpty
                            ? CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.red,
                                child: Text(
                                  '${cartProvider.cartItems.length}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              )
                            : Container();
                      }),
                    ),
                  ],
                ),
              ),
              // Icon button to navigate to ProfileScreen page
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, "profile"); // Use ProfileScreen.id for the route
                },
                icon: Icon(
                  Icons.person,
                  color: Colors.cyan.shade600,
                ),
              ),
            ],
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Shoppingo",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 26, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16, top: 60),
        child: Column(
          // Use Column to stack widgets
          children: [
            // Welcome message with username and heart icon
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome ${user?.email?.split('@')[0] ?? "Guest"}!', // Display username or "Guest"
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 30, // Size of the heart icon
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),

            Expanded(
              // Use Expanded to take up remaining space
              child: FutureBuilder<List<ProductModel>>(
                future: AllProductService().getAllProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    List<ProductModel> products = snapshot.data!;
                    return GridView.builder(
                      itemCount: products.length,
                      clipBehavior: Clip.none,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.5,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 100,
                      ),
                      itemBuilder: (context, index) {
                        return CustomCard(
                          product: products[index],
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text(
                        'No products available',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
