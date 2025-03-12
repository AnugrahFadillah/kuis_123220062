class ClothesModel {
  String name;
  double price;
  String category;
  String brand;
  List<String> sizes;
  List<String> colors;
  int sold;
  double rating;
  String imageUrl;

  ClothesModel({
    required this.name,
    required this.price,
    required this.category,
    required this.brand,
    required this.sizes,
    required this.colors,
    required this.sold,
    required this.rating,
    required this.imageUrl,
  });
}