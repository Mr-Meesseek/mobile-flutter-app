import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_mobile_app/provider/cart_provider.dart';
import 'package:ecommerce_mobile_app/provider/favorite_provider.dart';
import 'package:ecommerce_mobile_app/provider/category_provider.dart';
import 'package:ecommerce_mobile_app/screens/login/login_screen.dart';
import 'package:ecommerce_mobile_app/screens/nav_bar_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginScreen(),
          '/home': (context) => const NavBarScreen(),
        },
      ),
    );
  }
}
