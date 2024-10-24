import 'package:flutter/material.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/screens/product_detailed_screen.dart';
import 'package:store_app/screens/update_product_page.dart';

class CustomCard extends StatelessWidget {
  CustomCard({
    required this.product,
    super.key,
  });
  ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailsPage.id, arguments: product);
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  blurRadius: 40,
                  spreadRadius: 0,
                  offset: const Offset(10, 10),
                  color: Colors.grey.withOpacity(0.2))
            ]),
            child: Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title.substring(0, 6),
                      style: const TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 2.5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          r"$" "${product.price}",
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                        ),
                        Icon(
                          Icons.favorite,
                          color: Colors.cyan.shade600,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 35,
            top: -60,
            child: Image.network(
              product.image,
              width: 100,
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}
