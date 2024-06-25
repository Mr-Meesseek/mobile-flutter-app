import 'package:ecommerce_mobile_app/screens/Cart/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_mobile_app/models/product_model.dart';
import 'package:ecommerce_mobile_app/constants.dart';
import 'package:ecommerce_mobile_app/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class AddToCart extends StatelessWidget {
  final Product product;

  const AddToCart({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: 85,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.black,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {
            Provider.of<CartProvider>(context, listen: false).addToCart(product);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartTest(cartItems: Provider.of<CartProvider>(context, listen: false).cart),
              ),
            );
          },
          child: Container(
            height: 55,
            decoration: BoxDecoration(
              color: kprimaryColor,
              borderRadius: BorderRadius.circular(50),
            ),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: const Text(
              "Add to Cart",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
