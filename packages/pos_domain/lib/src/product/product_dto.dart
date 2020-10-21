class ProductDTO {
  final int id;
  final String name;
  final double price;
  final String image;
  final String category;
  final int variant;

  ProductDTO({
    this.id,
    this.name,
    this.price,
    this.image,
    this.category,
    this.variant,
  });

  int get safeVariant => variant ?? 0;

}
