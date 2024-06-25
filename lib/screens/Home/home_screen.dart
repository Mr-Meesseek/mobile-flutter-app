  import 'dart:convert';
  import 'dart:typed_data';
  import 'package:flutter/material.dart';
  import 'package:ecommerce_mobile_app/models/product_model.dart';
  import 'package:ecommerce_mobile_app/services/api_service.dart';
  import 'package:provider/provider.dart';
  import 'package:ecommerce_mobile_app/provider/category_provider.dart';
  import 'package:ecommerce_mobile_app/screens/Home/widget/search_bar.dart';
  import 'package:ecommerce_mobile_app/screens/Home/widget/home_app_bar.dart';
  import 'package:ecommerce_mobile_app/screens/Home/widget/image_slider.dart';
  import 'package:ecommerce_mobile_app/screens/Home/widget/product_cart.dart';
  import '../../models/category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> products = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchProducts();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
    });
  }

  fetchProducts() async {
    try {
      products = (await ApiService().getProducts()).cast<Product>();
      isLoading = false;
    } catch (e) {
      errorMessage = e.toString();
      isLoading = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 35),
              const CustomAppBar(),
              const SizedBox(height: 20),
              const MySearchBar(),
              const SizedBox(height: 20),
              ImageSlider(
                currentSlide: 0,
                onChange: (value) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 20),
              categoryProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : categoryProvider.errorMessage.isNotEmpty
                      ? Center(child: Text(categoryProvider.errorMessage))
                      : categoryProvider.categories.isEmpty
                          ? const Center(child: Text('No categories available'))
                          : categoryItems(categoryProvider.categories),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Special For You",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    "See all",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : errorMessage.isNotEmpty
                      ? Center(child: Text(errorMessage))
                      : GridView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.75,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return ProductCard(
                              product: product,
                            );
                          },
                        ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox categoryItems(List<Category> categories) {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final category = categories[index];
          final imageBytes = base64Decode(category.image);

          return GestureDetector(
            onTap: () {
              setState(() {
                // Handle category selection
              });
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.transparent,
              ),
              child: Column(
                children: [
                  Container(
                    height: 65,
                    width: 65,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: MemoryImage(Uint8List.fromList(imageBytes)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    categories[index].title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
