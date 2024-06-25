import 'dart:convert';
import 'package:ecommerce_mobile_app/models/category.dart'; // Add this import
import 'package:ecommerce_mobile_app/models/product_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://192.168.209.67:8000";

  Future<List<Product>> getProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/product'));
      if (response.statusCode == 200) {
        List<dynamic> productList = jsonDecode(response.body)['products'];
        return productList.map((data) => Product.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
  
  Future<List<Category>> getCategories() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/categories'));
      if (response.statusCode == 200) {
        List<dynamic> categoryList = jsonDecode(response.body)['categories'];
        return categoryList.map((data) => Category.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }
}
