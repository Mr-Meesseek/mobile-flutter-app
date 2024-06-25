class Category {
  final String title;
  final String image;

  Category({
    required this.title,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      title: json['title'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
