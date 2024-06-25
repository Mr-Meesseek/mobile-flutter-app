import 'package:flutter/material.dart';
import 'package:ecommerce_mobile_app/models/product_model.dart';

class CartProvider with ChangeNotifier {
  final List<Product> _cart = [];

  List<Product> get cart => _cart;

  void addToCart(Product product) {
    _cart.add(product);
    notifyListeners();
  }
}
