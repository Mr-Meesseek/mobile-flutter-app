import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ecommerce_mobile_app/models/product_model.dart';

class CartTest extends StatelessWidget {
  final List<Product> cartItems;

  const CartTest({Key? key, required this.cartItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final cartItem = cartItems[index];
          final imageBytes = Base64Decoder().convert(cartItem.imageBase64);

          return ListTile(
            leading: Image.memory(imageBytes),
            title: Text(cartItem.name),
            subtitle: Text("\$${cartItem.price}"),
          );
        },
      ),
    );
  }
}
