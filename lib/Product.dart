class Product {
  final String imageUrl;
  final String name;
  final String percentage;
  final String actualPrice;
  final String discountPrice;

  Product(
      {required this.imageUrl,
      required this.actualPrice,
      required this.discountPrice,
      required this.name,
      required this.percentage});
}
