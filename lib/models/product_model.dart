class Product {
  final int id;
  final String name;
  final String category;
  final String imageBase64;
  final double price;
  final String description;
  final String review;
  final String seller;
  final List<String> colors;
  final double rate;
  final String title;
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.imageBase64,
    required this.price,
    required this.description,
    required this.review,
    required this.seller,
    required this.colors,
    required this.rate,
    required this.title,
    required this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      imageBase64: json['image_base64'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      description: json['description'] ?? '',
      review: json['review'] ?? '',
      seller: json['seller'] ?? '',
      colors: List<String>.from(json['colors'] ?? []),
      rate: (json['rate'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 1,
      title: json['title'] ?? '',
    );
  }
}
